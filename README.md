ICG Bonus Submission Deliverables: By Ethan Harder 100877874, and Alexander Hamblin 100874915

USER INPUTS:
to make the enemy in a vulnerable state: Space Bar. (Also to cancel)
to take a hit from the enemy: Left Shift. (Cancels automatically).


Core Analysis: Game involves combat between you an an opponent.
game Features we wanted to retain and implement through shaders
  -Enemy features a vulnerable state when its obvious you can deal large amounts of damage.
Derived from the idea of the player's charged uppercut attack.
  -Emphasis effect on the camera when user is hit.
Drawn from 2d games of similar titles and the game's idea of punching each other (being dazed and seeing gray is a common and fun concept for conveying disorientation or concussion(?).
  -Player has some kind of motion
Generally, Boxing is conveyed with the swaying of the fighters. We wanted to implement this in a way that feels smooth, rather then a rough script-based implementation.




Implementation 1: Vulnerable State.
<img width="474" alt="image" src="https://github.com/user-attachments/assets/d858c4b6-1780-4869-b29d-022996c84553">
![image](https://github.com/user-attachments/assets/e2fd663e-f3f7-4474-b512-eb3784215b34)
This shader starts with the prebuilt Toon Lighting as taught in class. We expanded this was a bool that is enabled via script, that causes a rim lighting effect, and a vertex offset effect.

  -The Rim lighting effect's magnitude is modified by _Time.z with a constant modifier and put under Sine to case a repeated pulsing flash, showing an affordance of being vulnerable, as flashing red is a common 'low health' indication in games of this style.
  -The vertex offset effect is enacted in the vertex shader along their normals. It uses the same _Time.z Sine format, to make the enemy himself pulse in time with the flashing. We added this because it conveys throbbing, a cartoonish visual of throbbing as if being hit/ stubbing toe. collectevely these additions seem to effectively convey the enemy is hurt and you are on the offensive.
<img width="340" alt="image" src="https://github.com/user-attachments/assets/2bf33056-7444-4c25-8090-460a69e8616b">

Implementation 2: Color Shift on player Hit.
<img width="379" alt="image" src="https://github.com/user-attachments/assets/e9a9585a-0b49-4524-a390-7aff58a0c492">
<img width="362" alt="image" src="https://github.com/user-attachments/assets/afad35c8-c58f-41b6-97c2-a79515a65718">

We use the pre-designed LUT ColorGrading script/Shader combination. Built in photoshop, we create a greyscale effect, reminiscent of other game impact frames, where the screen goes achromatic for a moment when struck. The script we implement alongside it modified the contribution when not struck and raises it when struck, while running a coroutine to disable it automatically (and convey the brief impact frame effect we were going for).
<img width="144" alt="image" src="https://github.com/user-attachments/assets/696a980f-6000-45e8-bc13-2f150a78e904">

Implementation 3: Player Sway.

This shader is derived from the vertex extruding shader. It has been modified to remove the normals of the vertices and instead modifies each vertex along world space (X position). It is modified by _Time, and a sway float variable to multiply against, all under Sine to make it bob back and forth, hopefully similar to a real fighter in combat. it also shifts the normals along the same path so it doesnt distort the texture (though the texture is a reused toon ramp due to time constraints).
  
