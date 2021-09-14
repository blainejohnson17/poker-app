Rails.application.routes.draw do
  post "/graphql", to: "graphql#execute"
  get '/', to: "rails/welcome#index"
end
