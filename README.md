# Poker App

## Description

The application is comprised of seperate UI (react) and API (rails).
- [UI Folder](./poker-ui)
- [API Folder](./poker-api)

The react UI application calls a graphql API to fetch Player details as well as a list of all Games played.
The player details include player name, id and win count.
Each game includes the card hands. Each hand includes playerID and win status.

### Live Demo
- [UI Application](https://poker-ui-dev.herokuapp.com/)
- [API Application](https://poker-api-dev.herokuapp.com/)


### Example Data
1000 example games will be loaded via rails seed task `rails db:seed`