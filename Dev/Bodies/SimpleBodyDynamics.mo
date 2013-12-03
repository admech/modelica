within Dev.Bodies;
model SimpleBodyDynamics
      import Modelica.Mechanics.MultiBody.Frames;
      Modelica.Mechanics.MultiBody.Interfaces.Frame_a frame_a;
      parameter SI.Position r_CM[3](start = {0,0,0});
      parameter SI.Mass m(min = 0, start = 1);
      parameter SI.Inertia I_11(min = 0) = 0.001; 
      parameter SI.Inertia I_22(min = 0) = 0.001; 
      parameter SI.Inertia I_33(min = 0) = 0.001; 
      parameter SI.Inertia I_21 = 0; 
      parameter SI.Inertia I_31 = 0; 
      parameter SI.Inertia I_32 = 0; 

      SI.Position r_0[3](start = {0,0,0});
      SI.Velocity v_0[3](start = {0,0,0}); 
      SI.Acceleration a_0[3](start = {0,0,0}); 

      final parameter SI.Inertia I[3,3] = [I_11,I_21,I_31;I_21,I_22,I_32;I_31,I_32,I_33] "inertia tensor";
      final parameter Frames.Orientation R_start = Modelica.Mechanics.MultiBody.Frames.nullRotation();
      SI.AngularVelocity w_a[3](start = Frames.resolve2(R_start, zeros(3)));
      SI.AngularAcceleration z_a[3](start = Frames.resolve2(R_start, zeros(3)));
      SI.Acceleration g_0[3];

    protected
//      outer Modelica.Mechanics.MultiBody.World world;
 	  outer Dev.World world;
      parameter SI.Angle phi_start[3] = zeros(3);
      SI.Angle phi[3](start = phi_start);
      SI.AngularVelocity phi_d[3];
      SI.AngularAcceleration phi_dd[3];
    equation
      Connections.potentialRoot(frame_a.R);
      r_0 = frame_a.r_0;
      phi_d = der(phi);
      phi_dd = der(phi_d);
      frame_a.R = Frames.axesRotations({1,2,3}, phi, phi_d);

      g_0 = world.gravityAcceleration(frame_a.r_0 + Frames.resolve1(frame_a.R, r_CM));
      v_0 = der(frame_a.r_0);
      a_0 = der(v_0);
      w_a = Frames.angularVelocity2(frame_a.R);
      z_a = der(w_a);

      frame_a.f = m * (Frames.resolve2(frame_a.R, a_0 - g_0) + cross(z_a, r_CM) + cross(w_a, cross(w_a, r_CM)));
      frame_a.t = I * z_a + cross(w_a, I * w_a) + cross(r_CM, frame_a.f);
end SimpleBodyDynamics;