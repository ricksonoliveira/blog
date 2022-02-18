# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     Blog.Repo.insert!(%Blog.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.
alias Blog.{Accounts, Posts}

user = %{
  email: "riksongleison471@gmail.com",
  first_name: nil,
  image:
    "https://lh3.googleusercontent.com/a-/AOh14Ggj38VbKMhfIQKgGLrX-DQfQj8TZWdULXTwp0ea7A=s96-c",
  last_name: nil,
  provider: "google",
  token:
    "ya29.A0ARrdaM949iSTPMJXI1JC64ncsxC8vxNCJtGdvbYc6gFJbDbSNYKV2x3pJ8b4ugLpaUBs3etmV7MGT1pN_C8868KM25aN5x1nEHYIxEiwW_aHV3-851CfCod-OdzSHs-dbkwQUy3WaOJcOQ-kr0SPg2AndHO9"
}

user_two = %{
  email: "asdasd@gmail.com",
  first_name: nil,
  image:
    "https://lh3.asdasd.com/a-/AOh14Ggj38VbKMhfIQKgGLrX-DQfQj8TZWdULXTwp0ea7A=s96-c",
  last_name: nil,
  provider: "google",
  token:
    "ya29.A0ARrdaasdasM949iSTPMJXI1JC64ncsxC8vxNCJtGdvbYc6gFJbDbSNYKV2x3pJ8b4ugLpaUBs3etmV7MGT1pN_C8868KM25aN5x1nEHYIxEiwW_aHV3-851CfCod-OdzSHs-dbkwQUy3WaOJcOQ-kr0SPg2AndHO9"
}

post = %{
  title: "Postgres SQL",
  description:
    "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum."
}

{:ok, user} = Accounts.create_user(user)
{:ok, _user_two} = Accounts.create_user(user_two)
{:ok, _phoenix} = Posts.create_post(user, post)
