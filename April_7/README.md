# Snake
## A remake of the snake game done using OOP. Images on this folder should be in the same folder as snake.pde.

# Screenshot
[<img align="center" src="https://github.com/youssef-ahamid/introToIM/blob/master/April_7/screenshot.png" alt="screenshot" width="800">](#)



# Classes
## Food
The food class randomizes the spawn location of the fruit, picks a random fruit, and shows the fruit in display().

## Snake Elements (SnakeBaby)
A class representing individual circle in the snake. Shows the snake element in display() and creates the wrappingb around effect for the snake in wrapAround()

## Snake
Controls moving/adding snake elements and checking for lose condition

## Game
Spawns Snake, controls fruit creation, tracks score, pauses game, brings everything together

# Features
- Graphics

- Ability to pause game by pressing the spacebar

- Ability to restart game

- Snake wraparound

- Score tracking

# Tricky parts
## Moving the snake
At the beginning, I was moving every snake element up,down,right,left, but the whole snake would move in these directions as a block. After some thinking, I decided on iterating over every snake element from back to front, moving each element to the position of the element in front of it. Then, the head is moved in the direction of the snake.
## Loading images
I spent hours trying to figure out some error, and it turns out that images need to be loaded either in setup or AFTER setup finishes implementing.
## Problem with width and height
I programmed the game to be dynamic; just changing the x and y size in setup should change everything (image sizes, step size, etc.). This relied on setting a variable = width and height. For some reason, when I did that, the screen turns infinitismly small. I tried moving everything around and the problem persisted. Google was no help either. 


