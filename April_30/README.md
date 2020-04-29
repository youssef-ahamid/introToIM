# Google Dinosaur game clone
## A clone of google's hidden dinosaur run game.

## Instructions
- game starts with idle dinosaur
- jump over obstacles using the spacebar
- randomize the dinosaur's color by pressing d
- randomize the cacti's color by pressing c
- randomize the cloud's color by pressing s
- the more the dinosaur stays alive, the higher your score!


## Features 
- graphics
- collision detection
- changing the color of images
- score tracking
- saving high score to csv file

## Explanation of a tricky part in code
Instead of using arrays of images, i am using sprites, which is more optimal.  A sprite is an image that contains multiple images inside of them stacked next to each other.  Let's say you have 5 images and you want to create an animation with them. Instead of placing the images in an array, you can use a sprite of these images by doing this following trick. Each image has the same width and height, since they are the same image at different stages of the animation. in the case of an array, you have an index of the current image, and you move to the next index every frame. With sprites we also have indeces, but instead of displaying a different image every frame, we simply crop the image from the index * width to the (index + 1) * width. 

Here is a graphical explanation of this concept:
[<img align="center" src="https://github.com/youssef-ahamid/introToIM/blob/master/April_30/explanation.jpg" alt="explanation" width="400">](#)
