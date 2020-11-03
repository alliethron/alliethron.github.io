

def displayFullMenu(menuList):

    i=0
    for c in menuList:
        print(str(i+1) + " - " + c[-3] + "-" + c[-2] + ", " + "$"+c[-1])
        i += 1
    print(str(i+1) + " - " + "Back to main menu")

def getChoice():
    print()
    choice = eval(input(">>"))
    return choice

def displayMenu():
    print()
    print("Menu Selection")
    print("================================")
    print("enter 1 to search for a dish")
    print("enter 2 to start building your meal")
    print("enter 3 to quit")



def loadCourses(filename):
    mlist=[]
    ifile = open(filename, 'r')
    for line in ifile:
        menu = line.rstrip().split(',')

        mlist.append(menu)
    ifile.close()
    return mlist
    #print(mlist)


def printMenuItem(item):
    print(item) #fix

def printSelection(selectionList):
    print("Current selections")
    print("=================")
    i =0
    total=0
    for item in selectionList:
        print(str(i + 1) + " - " + item[0] + "\t" + item[1] + "\t" + "$"+ item[2] )
        i += 1
        total = total + int(item[2])
    print("\n Your current total is " + "$" + str(total))

'''def search(menuList, searchItem):
    found= False
    for item in menuList:
            if(item[1].strip().upper() == searchItem.strip().upper()):
                printMenuItem(item)
                found = True
    if not found:
            print("We're sorry, " + searchItem + " isn't on the menu!")'''

def search(menuList, searchItem):
    i =0
    for item in menuList:
        if(item[1].strip().upper() == searchItem.strip().upper()):
            printMenuItem(item)
        else:
            print("ahh")





def main():

    ifilename = "menu.txt"
    menuList = []
    selectionList = []
    #loadCourses(menuList, ifilename)
    menuList = loadCourses(ifilename)
    print(menuList)
    choice = -1
    while(choice!=3):
        displayMenu()
        choice = getChoice()
        if (choice==1):
            searchItem = input("What are you looking for? >> ")
            search(menuList, searchItem)
        elif (choice==2):
            displayFullMenu(menuList)
            addChoice = getChoice();

            if (1<=addChoice<len(menuList) and addChoice!=len(menuList)+1):
                addedItem=menuList[addChoice-1]

                if addedItem not in selectionList:
                    selectionList.append(addedItem)
                elif addedItem in selectionList:
                    duplicate = input("Item already added, add again? Yes/No: ")
                    if duplicate.upper()=="YES":
                        selectionList.append(addedItem)
                    else:
                        print()
            elif (addChoice==len(menuList)+1):
                continue
            else:
                print("Item not on menu!")
        elif (choice==3):
            return








           # if (1<=addChoice<len(menuList) and addChoice!=len(menuList)+1):
               # addedItem=menuList[addChoice-1]
                #if addedItem not in selectionList:
                #    selectionList.append(addedItem)
               # else:
                 #   print("You have already added this item")
               # printSelection(selectionList)
           # elif (addChoice==len(menuList)+1):
              #  continue
           # else:
               # print("not an option")
       # elif (choice==2):
            #isplayFullMenu(selectionList)
           # print("item to drop ", end="")
           # dropChoice = getChoice()
           # if (1<=dropChoice<len(selectionList) and len(selectionList)>0):
            #    selectionList.pop(dropChoice-1)
              #  printSelection(selectionList)
      #  elif (choice==3):
          #  return






if __name__==("__main__"):
    main()


















