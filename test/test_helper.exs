# Remove the test database if it already exists.
#Arangoex.Database.remove("test")

# Create the test database.
#Arangoex.Database.create(%{name: "test"})

# Run the tests.
ExUnit.start()
