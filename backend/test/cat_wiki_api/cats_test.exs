defmodule CatWikiAPI.CatsTest do
  use CatWikiAPI.DataCase

  describe "breeds" do
    alias CatWikiAPI.Cats.Breed
    alias CatWikiAPI.Mocks
    alias CatWikiAPI.Cats

    @valid_attrs Mocks.BreedStruct.get()
    @breed_name @valid_attrs.name

    @update_attrs %{name: "happycat"}
    @invalid_attrs %{name: nil}

    def breed_fixture(attrs \\ %{}) do
      {:ok, breed} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Cats.create_breed()

      breed
    end

    test "list_breeds/0 returns all breeds" do
      breed = breed_fixture()
      assert Cats.list_breeds() == [breed]
    end

    test "get_breed!/1 returns the breed with given id" do
      breed = breed_fixture()
      assert Cats.get_breed!(breed.id) == breed
    end

    test "create_breed/1 with valid data creates a breed" do
      assert {:ok, %Breed{} = breed} = Cats.create_breed(@valid_attrs)
      assert breed.name == @breed_name
      assert breed.views == 0
    end

    test "create_breed/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Cats.create_breed(@invalid_attrs)
    end

    test "update_breed/2 with valid data updates the breed" do
      breed = breed_fixture()
      assert {:ok, %Breed{} = breed} = Cats.update_breed(breed, @update_attrs)
      assert breed.name == "happycat"
    end

    test "update_breed/2 with invalid data returns error changeset" do
      breed = breed_fixture()
      assert {:error, %Ecto.Changeset{}} = Cats.update_breed(breed, @invalid_attrs)
      assert breed == Cats.get_breed!(breed.id)
    end

    test "delete_breed/1 deletes the breed" do
      breed = breed_fixture()
      assert {:ok, %Breed{}} = Cats.delete_breed(breed)
      assert_raise Ecto.NoResultsError, fn -> Cats.get_breed!(breed.id) end
    end

    test "change_breed/1 returns a breed changeset" do
      breed = breed_fixture()
      assert %Ecto.Changeset{} = Cats.change_breed(breed)
    end
  end
end
