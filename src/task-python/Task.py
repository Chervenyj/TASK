
def count_backwards():
    num = int(input("Enter a number: "))

    for i in range(num, 0, -1):
        if i % 15 == 0:
            print("Testing")
        elif i % 3 == 0:
            print("Software")
        elif i % 5 == 0:
            print("Agile")
        else:
            print(i)


count_backwards()
