[<img align="right" src="https://github.com/youssef-ahamid/introToIM/blob/master/Final_Project/harold.png" alt="Icy Tower" width="100">](#)


# Icy Tower Clone

Icy Tower is a PC game from mid 2000's (my favorite game of all time). It is set in a tower, where the player's goal is to jump from one "floor" to the next and go as high as possible without falling or plunging off the screen.

## Instructions

- Help Harold climb the tower
- Use left and right arrow keys to move and space bar to jump
- The faster you run, the higher you jump
- Make double or triple jumps to activate combo mode and gain extra score

[<img align="left" src="https://github.com/youssef-ahamid/introToIM/blob/master/Final_Project/icy_tower.jpg" alt="Icy Tower" width="480">](#)
## Features
- Music and sound effects
- Graphics
- Score tracking
- Ability to play again
- Main menu
- Leaderboard that is updated every game
- Turn music and sound effects on/off
- Change difficulty
- Change character


## Plan for code: OOP
Code will contain the following classes:
- Player: character class
- Platform: class for floor which will display and update the position of the floor.
- Game: This class will initialize a hero and platforms, it will track the score and check if the game is over.
- Button: a class for the buttons in the game. It contains an image of the button, if provided one, and the position of the button.
- Screen: This class is an object for a screen of the game, e.g. game screen, main screen, instructions screen, etc. It will hold the background and all the buttons in a given screen and will display them.
- Main: this class is instantiated in setup and will control the game and screens. it creates new games when the user restarts and handles moving between screens.
