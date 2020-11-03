   
def main():
    number = listOfCards("cards.txt")


def listOfCards(fileName):

    infile = open(fileName, 'r')

    deckOfCards = [line.rstrip() for line in infile]
    infile.close()
    for i in range(len(deckOfCards)):
        deckOfCards[i] = deckOfCards[i].split(',')
        deckOfCards[i][2]=eval(deckOfCards[i][2])
        number=deckOfCards[:]
        #print(number)
    return number

    return deckOfCards

game_stats=[]
import time
startTime=time.time()

print("Let's play a game! Here are the rules: The computer will draw a card. \n\
You must guess if the next card will be higher or lower in value than \n\
the current card (Ace high). You win if can score 4 in a row! If the next \n\
card has the same value as the current card, you get the point for that round.\n\
Your score resets to zero everytime you miss a card. Good Luck!")



import random

number = listOfCards('cards.txt')
number2 = number[:]
number3 = number2[:]
number4 = number3[:]

for i in range(len(number2)):
    number3[i] = number2[i][2] #card value
    number4[i]=number2[i][0:2] #rank
   # print(number2)


random.shuffle(number2)
score=0
rounds=0
card = number2.pop(0)        #remove card after its drawn
while score<4:
        while True:

            print("\nYour score so far is", score)
            print("\n\n the current card is", card[0:2])
            while True:
                guess = input("\nHigher or Lower? Enter H for higher or L for lower: ")
                if len(guess) >0:
                    if guess.upper() in ["H", "L"]:
                        rounds+=1

                        break

            card2 = number2.pop(0)


            if guess.upper() == "H" and card2[2]>card[2]:
                print("\nCorrect!")
                score+=1

            if guess.upper() == "H" and card2[2]<card[2]:
                print("\nIncorrect!")
                score=0

            if guess.upper() == "L" and card2[2]<card[2]:
                print("\nCorrect!")
                score+=1

            if guess.upper() == "L" and card2[2]>card[2]:
                print("\nIncorrect!")
                score=0


            if card2[2]==card[2]:
                print("Same value, correct!")
                score+=1



            card = card2
            print("\nthe next card was", card2[0:2])
            if score >= 4:
                print("You win!")
                break

            continue


        break

from os.path import join

elapsedTime=time.time()-startTime

print("It took you", rounds, "rounds and", round(elapsedTime), "seconds to finish!")



stats=[rounds, elapsedTime]
outfile=open("game_stats.txt", "a")
outfile.write("Rounds: ")
outfile.write(str(rounds) + "\n")
outfile.write("Time: ")
outfile.write(str(elapsedTime)+ "\n")

outfile.close()



main()






















