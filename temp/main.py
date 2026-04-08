class Dog:
    # Constructor: Initializes the object's attributes
    def __init__(self, name, breed):
        self.name = name   # Instance attribute
        self.breed = breed # Instance attribute

    # Method: Defines a behavior for the object
    def bark(self):
        return f"{self.name} says Woof!"

# 1. Create an object (instantiation)
my_dog = Dog("Buddy", "Golden Retriever")

# 2. Access attributes and call methods
print(f"My dog's name is {my_dog.name}.") # Output: Buddy
print(my_dog.bark())                       # Output: Buddy says Woof!
