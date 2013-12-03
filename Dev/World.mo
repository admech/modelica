within Dev;

model World
	import Modelica.Mechanics.MultiBody.Frames;
	
    Modelica.Mechanics.MultiBody.Interfaces.Frame_b frame_b;
    
    function gravityAcceleration
    	input Real[3] r_CM; //for compatibility
    	output Real[3] g;
    algorithm
    	g := {0, 0, -1};
	end gravityAcceleration;    
equation
  Connections.root(frame_b.R);

  frame_b.r_0 = zeros(3);
  frame_b.R = Frames.nullRotation();

end World;