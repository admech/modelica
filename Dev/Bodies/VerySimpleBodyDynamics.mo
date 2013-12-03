within Dev.Bodies;
model VerySimpleBodyDynamics
      import Modelica.Mechanics.MultiBody.Frames;
      Modelica.Mechanics.MultiBody.Interfaces.Frame_a frame_a;

//      parameter SI.Mass m(min = 0, start = 1);
	  parameter Real m = 1;

      Real[3] r_0(start = zeros(3));
      Real[3] v_0(start = zeros(3)); 
      Real[3] a_0(start = zeros(3)); 

      Real[3] g_0;

    protected
//    outer Modelica.Mechanics.MultiBody.World world;
      outer Dev.World world;

      Real[3] phi(start = zeros(3));
    equation
      Connections.potentialRoot(frame_a.R);
      r_0 = frame_a.r_0;

//    frame_a.R = Frames.nullRotation();
      frame_a.R = Frames.axesRotations({1,2,3}, phi, zeros(3));

      g_0 = world.gravityAcceleration(frame_a.r_0);
      v_0 = der(frame_a.r_0);
      a_0 = der(v_0);

      frame_a.f = m * (Frames.resolve2(frame_a.R, a_0 - g_0) );
      //OMG!!!
      frame_a.t = phi;
end VerySimpleBodyDynamics;