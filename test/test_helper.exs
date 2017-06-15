# Connect to the database.
Arangoex.start_link(name: :arango)

# Remove the test database if it already exists.
Arangoex.Database.remove(:arango, "test")

# Create the test database.
Arangoex.Database.create(:arango, %{name: "test"})

# Run the tests.
ExUnit.start()
