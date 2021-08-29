# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
users = [
  %{
    email: "jwbaldwin3@gmail.com",
    password: "password12345"
  }
]

for user <- users do
  {:ok, user} = Mmentum.Accounts.register_user(user)
  {encoded_token, user_token} = Mmentum.Accounts.UserToken.build_email_token(user, "confirm")
  Mmentum.Repo.insert!(user_token)
  Mmentum.Accounts.confirm_user(encoded_token)
end
