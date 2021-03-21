defmodule Mix.Tasks.Db.Gen.Users do
  @moduledoc """
  A task to populate the database with some users.
  """
  use Mix.Task

  @spec run(any) :: list
  def run(_) do
    Mix.Task.run("app.start")

    # Great Singers
    [
      "Amalia Rodrigues",
      "Freddie Mercury",
      "Gordon Matthew Thomas Sting",
      "Elis Regina",
      "Aretha Franklin"
    ]
    |> create_users(:guardian)

    # Disney Characters
    [
      "Peter Pan",
      "Buzz Lightyear",
      "Pato Donald",
      "Cruella de Vil",
      "Branca de Neve"
    ]
    |> create_users(:mentor)

    # Pokémons
    [
      "Bulbasaur Fushigidane",
      "Charmander Hitokage",
      "Squirtle Zenigame",
      "Pikachu Pikachu",
      "Nidorina Nidorina",
      "Psyduck Kodakku",
      "Snorlax Kabigon"
    ]
    |> create_users(:ninja)
  end

  defp create_users(characters, role) when role in [:guardian, :mentor, :ninja] do
    for character <- characters do
      user = gen_user(character, role)

      names = split_names(character)

      case Bokken.Accounts.create_user(user) do
        {:error, changeset} ->
          Mix.shell().error(Kernel.inspect(changeset.errors))

        {:ok, %{id: user_id}} when role == :guardian ->
          gen_guardian(names, user_id)

        {:ok, %{id: user_id}} when role == :mentor ->
          gen_mentor(names, user_id)

        {:ok, %{id: user_id}} when role == :ninja ->
          gen_ninja(names, user_id)
      end
    end
  end

  defp gen_user(character, role) do
    email = character |> String.downcase() |> String.replace(~r/\s*/, "")

    %{
      email: email <> "@mail.com",
      password: "password1234",
      verified: true,
      active: true,
      role: role
    }
  end

  defp gen_guardian(names, user_id) do
    mobile =
      "+351 9#{Enum.random([1, 2, 3, 6])}#{
        for _ <- 1..7, do: Enum.random(0..9) |> Integer.to_string()
      }"

    city = Enum.random(Jason.decode!(File.read!("data/pt/cities.json")))

    photo = "https://robohash.org/#{names.first_name}-#{names.last_name}"

    guardian = Enum.into(names, %{user_id: user_id, photo: photo, mobile: mobile, city: city})

    Bokken.Accounts.create_guardian(guardian)
  end

  defp gen_ninja(names, user_id) do
    birthday = %Date{
      year: Enum.random(1995..2013),
      month: Enum.random(1..12),
      day: Enum.random(1..28)
    }

    belt = Enum.random([nil, :white, :yellow, :blue, :green, :orange, :red, :purple, :black])

    %{id: guardian_id} = Enum.random(Bokken.Accounts.list_guardians())

    photo = "https://robohash.org/#{names.first_name}-#{names.last_name}"

    ninja =
      Enum.into(names, %{
        user_id: user_id,
        guardian_id: guardian_id,
        photo: photo,
        belt: belt,
        birthday: birthday
      })

    Bokken.Accounts.create_ninja(ninja)
  end

  defp gen_mentor(names, user_id) do
    mobile =
      "+351 9#{Enum.random([1, 2, 3, 6])}#{
        for _ <- 1..7, do: Enum.random(0..9) |> Integer.to_string()
      }"

    birthday = %Date{
      year: Enum.random(1995..2013),
      month: Enum.random(1..12),
      day: Enum.random(1..28)
    }

    photo = "https://robohash.org/#{names.first_name}-#{names.last_name}"

    mentor =
      Enum.into(names, %{
        user_id: user_id,
        mobile: mobile,
        trial: false,
        photo: photo,
        birthday: birthday
      })

    Bokken.Accounts.create_mentor(mentor)
  end

  defp split_names(name) do
    [first_name | other_names] = String.split(name)
    family_names = Enum.join(other_names, " ")
    %{first_name: first_name, last_name: family_names}
  end
end