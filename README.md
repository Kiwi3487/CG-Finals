Deliverables 

camera move script
To look around the scene QOL
this is a script

LUT Shader
Lut is a great way to set the mood of a game and since this map take pl;ace in space i've added a cool lut to the camera using an old lut table i've created
This is created using a material, script and a shader
How lut works is it takes 3D texture as a look-up table to map the RGB colorsproduced by the renderer to a different set of RGB colors which is thecolor-graded output.
Get scene color and saturates it between 0 and 1 uses precise sampling so it doeent go over then calculates offset to map the image to the LUT
![image](https://github.com/user-attachments/assets/fc77e56f-0d10-4f21-8947-590a56b51f46)
![image](https://github.com/user-attachments/assets/0a49580b-4b82-47fb-978b-3dde92a59893)


Vertex color & outline
This is using for the rainbow ground, I used vertex coloring to change the color of each material respectively meaning there 6 different materials where i changed the rng value to get the color I require, and by combine that with a scroll property and a website that allows me to get the RGB value for each color(QOL)
https://www.rapidtables.com/web/color/RGB_Color.html
This is created using multiple materials and a single shader
This shader come in 2 seprate parts the vertext color where I basically inilialize all the vertexes and output a RGB value onto the vertex and then transform the data onto the screen since i only needed one color or each tile I only used one channel and had it display a constant color 
the second part is the outline where I bascially extruded vertices outward by normal direction then set a color before outputing everything
![image](https://github.com/user-attachments/assets/1d782fd0-6d0e-40e6-9bce-d1cec55ea574)


Pixelation Shader
Since this is a rather old game so is the graphics mainly consisting of low bit texture so i decided to add a pixelations shader to the camera making the whole scene look retro
this is created using a script and material
How this shader works is it takes the density of pixels that makes up an objects and increase or decrase based on vlaues
![image](https://github.com/user-attachments/assets/66f269a8-8f68-4274-979d-6c5b976fc74b)
![image](https://github.com/user-attachments/assets/e103358d-9f1b-4556-8a73-022e920b15e9)



Metal Shader
thwomp is a enemy in the game they are mainly grey and look metallic in newer version they appear in so i decided to give the thwomp a metallic shader
this is created using a script and a material
This shader is made by seting the Albedo (base color) using the color property then setting the sample the metallic texture and use its red channel for smoothness then setting the Metallic value, combining the scalar with the texture
This is done beucase i only needed a simple matalic look on the thwomp
![image](https://github.com/user-attachments/assets/14f146d7-ab03-464c-8ec5-283e508bdb2d)


