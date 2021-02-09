<img src="https://bit.ly/2VnXWr2" alt="Ironhack Logo" width="100"/>

# Blackjack Game by Leo
*Leonardo Cavalcante Araújo*

*Data Analysis Full-Time FEB2021, Paris & February 8th 2021*

## Content
- [Project Description](#project-description)
- [Game Objective](#game-objective)
- [Rules](#rules)
    -  [Main Rules](#main-rules)
    -  [Specificities](#specificities)
- [Workflow](#workflow)
- [Organization](#organization)
- [Links](#links)

## Project Description
Being curious about a new game and also about the logic and math behind cards games, I have chosen to work on the Blackjack project.

The project consists in writing an online game of Blackjack where the user plays agains the CPU (which takes up the role of the dealer).

## Game Objective
The objective of the game is to acquire money through betting in each round of the game. Each round is composed by turns where the cards are drawn and their points are counted for each player to verify the winner of the round.

## Rules
The main rules apply, with some specificities stated below.

### Main Rules:
1. Every player starts with some ammount of cash in their account 
2. The game is composed by as many rounds as the player wishes, as long as he still has money to bet.
3. Order of play of 1 single round:
    - Pre-game: the player chooses the betting amount, the CPU always follows.
    - 1st round: 2 cards are drawn to the player initially and only 1 card is drawn to the CPU.
    - 2nd round and beyond: the player can draw as many additional cards as he wants, being conscious that above 21, he loses the game to the dealer.
    - Last round: if the player stoped with a score <= 21, the dealer can draw his cards until his hand presents a score of equal or greater 17.
3. Card scoring is applied : 
    - Cards 2 to 10: correspond to their numerical values
    - Face Cards (J, Q, K): counts as 10 points
    - Ace: either 1 or 11 points, which is decided by the one who draws this card.
4. The game ends when the player or the dealer don't have anymore funds to bet or when the player decides to quit in any InputBox prompted at the screen.

### Specificities
1. Multiple players is not possible: only holds the position for one player and the dealer (CPU).
2. The player can choose the size of the decks in the pre-game, for increasing level of dificulty in counting cards.
3. The CPU (dealer) automatically follows the bets of the player and both starts with the same pot at the beginning of the game.
4. Doubling down and splitting are not possible.

## Workflow
Outline the workflow you used in your project. What are the steps you went through?

My workflow was based on an iterative process, based on:
1. Creation of global variables, such as deck of cards, player variables and dealer/cpu variables.
2. Creation of functions
3. Creation of main code for execution of the game

After having build the first version following the steps above, it has been iterated 4 times to arrive in an optimized solution.

4. BONUS: Creation of the GUI interface, thanks to tkinter module (this version holds the name "Blackjack Game_vTKINTER.py")

## Organization
- Trello: for listing tasks and determining deadlines.
- Repository "data-ft-par-labs/Projects/Week-1/your-project" : you may find my 2 main Python codes stored as a Jupyter Notebook format and there's also a folder containing the image of the cards used to print the game visually while executing the code. This document containing all the appropriate links completes the files in the repository.  

- PS.: individual project.

## Links
Include links to your repository, slides and trello/kanban board. Feel free to include any other links associated with your project.

[Blackjack Game_vFINAL](https://github.com/leo-cavalcante/data-ft-par-labs/blob/main/Projects/Week-1/your-project/Blackjack%20Game_vFINAL.ipynb)  
[Blackjack Game_vTKINTER](https://github.com/leo-cavalcante/data-ft-par-labs/blob/main/Projects/Week-1/your-project/Blackjack%20Game_vTKINTER.ipynb)  
[GitHub Repository](https://github.com/leo-cavalcante/data-ft-par-labs/tree/main/Projects/Week-1/your-project)  
[Google Slides](https://docs.google.com/presentation/d/1551GoYrD76L0y5D45VVs1hfH_hPP5mTUOZQyBmd21X4/edit?usp=sharing)  
[Trello](https://trello.com/invite/b/w4QneQYo/5ace74351ce209a6104be71573fe1b96/blackjack)   
[BlackJack Rules](https://www.beatblackjack.org/rules/#:~:text=The%20values%20of%20the%20cards,is%20denoted%20as%207%2F17.)