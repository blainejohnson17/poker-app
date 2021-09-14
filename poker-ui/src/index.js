import React from 'react'
import ReactDOM from 'react-dom'
import {
  ApolloProvider,
  ApolloClient,
  createHttpLink,
  InMemoryCache
} from '@apollo/client';
import { useQuery, gql } from '@apollo/client';
import './application.scss';

const httpLink = createHttpLink({
  uri: 'https://poker-api-dev.herokuapp.com/graphql'
});

const client = new ApolloClient({
  link: httpLink,
  cache: new InMemoryCache()
});

const dataQuery = gql`
  {
    players {
      id
      name
      winningHands
    }
    games {
      id
      hands {
        cardCodes
        winner
        playerId
      }
    }
  }
`;

const GameList = ({children}) => {
  return(
    <div className={"game-list"}>
      {children}
    </div>
  )
}

const importAll = (r) => {
  let images = {};
  r.keys().forEach((item, index) => { images[item.replace('./', '')] = r(item); });
  return images
}

const images = importAll(require.context('./images/cards', false, /\.(png|jpe?g|svg)$/));

const Card = ({cardCode}) => {
  const [rankCode, suitCode] = cardCode.split('')
  const cardImageSrc = images[`${suitCode}_${rankCode}.jpg`].default
  return(
    <div className={"card"}>
      <img
        className="card--image"
        src={cardImageSrc}
      />
    </div>
  )
}

const CardList = ({children}) => {
  return(
    <div className={"card-list"}>
      {children}
    </div>
  )
}

const Hand = ({hand}) => {
  const className = hand.winner ? "hand winner" : "hand non-winner"
  return(
    <div className={className}>
      <div className={"hand--status"}>
        <span className={"hand--playerid"}>Player ID: {hand.playerId}</span>
        {hand.winner && <span className={"hand--winner"}>Winner</span>}
      </div>
      <CardList>
        {hand.cardCodes.map((cardCode) => <Card cardCode={cardCode} key={cardCode} />)}
       </CardList>
    </div>
  )
}

const HandList = ({children}) => {
  return(
    <div className={"hand-list"}>
      {children}
    </div>
  )
}

const Game = ({game}) => {
  const hands = [...game.hands].sort((a, b) => a.playerId - b.playerId).map((hand) => <Hand hand={hand} key={hand.playerId} />)
  return(
    <div className={"game"}>
      <h3>Game: {game.id}</h3>
      <HandList>
        {hands}
      </HandList>
    </div>
  )
}

const PlayerList = ({children}) => {
  return(
    <div className={"player-list"}>
      {children}
    </div>
  )
}

const Player = ({player}) => {
  return(
    <div className={"player"}>
      <h3>Player Details</h3>
      <span>Name: {player.name}</span>
      <span>ID: {player.id}</span>
      <span>Winning Hands: {player.winningHands}</span>
    </div>
  )
}

const App = () => {
  const { loading, error, data } = useQuery(dataQuery);

  if (loading) return 'Loading...';
  if (error) return `Error! ${error.message}`;

  return(
    <div className={"app"} >
      <PlayerList>
        {data &&
          data.players.map((player) => <Player key={player.id} player={player} />)
        }
      </PlayerList>
      <GameList>
        {data &&
          data.games.map((game) => <Game key={game.id} game={game} />)
        }
      </GameList>
    </div>
  )
}

ReactDOM.render(
  <ApolloProvider client={client}>
    <App />
  </ApolloProvider>,
  document.getElementById('root')
);