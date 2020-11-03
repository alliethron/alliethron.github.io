



def displayMenu(menuList):
    print(menuList[0][0].center(45))
    print("\n")
    for i in range(6):
        print(str(i+1)+menuList[i][1].ljust(30) +'$'.rjust(14)+menuList[i][2].ljust(15), sep="")
    print("\n")
    print(menuList[7][0].center(45))
    print("\n")
    for i in range(6,14):
        print(str(i+1)+menuList[i][1].ljust(30) + '$'.rjust(14) + menuList[i][2].ljust(15), sep="")
    print("\n")
    print(menuList[15][0].center(45))
    print("\n")
    for i in range(14,21):
        print(str(i+1)+menuList[i][1].ljust(30) + '$'.rjust(14) + menuList[i][2].ljust(15), sep="")
    print("\n")
    print(menuList[22][0].center(45))
    print("\n")
    for i in range(21,27):
        print(str(i+1)+menuList[i][1].ljust(30) + '$'.rjust(14) + menuList[i][2].ljust(15), sep="")

def getChoice():
    print()
    choice = eval(input(">>: "))
    return choice

def displayMainMenu():
    print()
    print("Welcome!")
    print("==================================")
    print("Enter 1 to search for a dish")
    print("Enter 2 to to add items")
    print("Enter 3 to clear selections and return to start page")

def displayOptions():
    print("Enter 2 to to add more items")
    print("Enter 3 to clear selections and return to start page")
    print("Enter 4 to delete most recent item")


def printSelection(item):
    print(item[1] + "\t" + "$" +item[2])
    print("Enter 1 to search again, or 2 to start adding!")

def itemNotFound():
    print("Enter 1 to search again, or 2 to start adding!")

def printMeal(selectionList):
    print("Here's what you have so far")
    print("=======================================================")
    i = 0
    total = 0
    for item in selectionList:
        i += 1

        print(item[1] + "\t" + "$" + item[2])

        total = total + eval(item[2])
    print(str(i) + " Item(s)")
    print("=======================================================")
    print("\n")
    print("\n Your current total is " + "$" + str(total)+"0")


def search(menuList,searchItem):
    found=False
    for item in menuList:
        if(searchItem.upper() in item[1].upper())  :
            printSelection(item)
            found=True
    if not found:
        print("We're sorry,  " + searchItem + " isn't on the menu")
        itemNotFound()

def loadMenu(fileName):
    infile=open(fileName, 'r')
    list1 = [line.strip() for line in infile]
    infile.close()
    for i in range(len(list1)):
        list1[i] = list1[i].split(',')
    return list1


def main():
    menuList=loadMenu("/Users/alliethron/PycharmProjects/pythonProject/menu.txt")
    displayMainMenu()
    #print(menuList)
    selectionList = []
    choice = -1
    while (choice != 3):
        #displayOptions()
        choice = getChoice()
        if (choice == 1):
            searchItem = input("What are you looking for? >> ")
            search(menuList, searchItem)
        elif (choice == 2):
            displayMenu(menuList)
            print("\nEnter the number of the item you'd like to add: ")
            addChoice = getChoice()
            if (1 <= addChoice < len(menuList) and addChoice != len(menuList) + 1):
                addedItem = menuList[addChoice - 1]

                if addedItem not in selectionList:
                    selectionList.append(addedItem)
                    printMeal(selectionList)
                    displayOptions()
                elif addedItem in selectionList:
                    duplicate = input("Item already added, add again? Yes/No: ")
                    if duplicate.upper() == "YES":
                        selectionList.append(addedItem)
                        printMeal(selectionList)
                        displayOptions()
                    else:
                        print()
                        printMeal(selectionList)
                        displayOptions()
            elif (addChoice == len(menuList) + 1):
                continue
            else:
                print("Item not on menu!")
                displayMainMenu()
        elif (choice == 3):
            displayMainMenu()
            choice=getChoice()
            if (choice == 1):
                searchItem = input("What are you looking for? >> ")
                search(menuList, searchItem)
            elif (choice == 2):
                displayMenu(menuList)
                print("\nEnter the number of the item you'd like to add: ")
                addChoice = getChoice()
                if (1 <= addChoice < len(menuList) and addChoice != len(menuList) + 1):
                    addedItem = menuList[addChoice - 1]

                    if addedItem not in selectionList:
                        selectionList.append(addedItem)
                        printMeal(selectionList)
                        displayOptions()
                    elif addedItem in selectionList:
                        duplicate = input("Item already added, add again? Yes/No: ")
                        if duplicate.upper() == "YES":
                            selectionList.append(addedItem)
                            printMeal(selectionList)
                            displayOptions()
                        else:
                            print()
                            printMeal(selectionList)
                            displayOptions()
                elif (addChoice == len(menuList) + 1):
                    continue
                else:
                    print("Item not on menu!")
                    displayMainMenu()
            elif (choice==3):
                displayMainMenu()
                choice = getChoice()
        elif(choice==4):
            
            del selectionList[-1]
            printMeal(selectionList)
            displayOptions()
    



main()

