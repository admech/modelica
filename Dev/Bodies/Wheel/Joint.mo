within Dev.Bodies.Wheel;
model Joint
	import Frame_a = Modelica.Mechanics.MultiBody.Interfaces.Frame_a;
	import Frame_b = Modelica.Mechanics.MultiBody.Interfaces.Frame_b;
	import Modelica.Mechanics.MultiBody.Frames;
	import Modelica.Mechanics.MultiBody.Frames.Orientation;

	Frame_a frame_a;
	Frame_b frame_b;
	
	parameter Real[3] axis;
	Real angle;
	Real derAngle;
	
	Orientation R_rel;
equation

   Connections.branch(frame_a.R, frame_b.R);

    assert(cardinality(frame_a) > 0,
      "Connector frame_a of revolute joint is not connected");
    assert(cardinality(frame_b) > 0,
      "Connector frame_b of revolute joint is not connected");

	derAngle = der(angle);

    frame_b.r_0 = frame_a.r_0;

    if rooted(frame_a.R) then
      R_rel = Frames.planarRotation(axis, angle, derAngle);
      frame_b.R = Frames.absoluteRotation(frame_a.R, R_rel);
      frame_a.f = -Frames.resolve1(R_rel, frame_b.f);
      frame_a.t = -Frames.resolve1(R_rel, frame_b.t);
    else
      R_rel = Frames.planarRotation(-axis, angle, derAngle);
      frame_a.R = Frames.absoluteRotation(frame_b.R, R_rel);
      frame_b.f = -Frames.resolve1(R_rel, frame_a.f);
      frame_b.t = -Frames.resolve1(R_rel, frame_a.t);
    end if;


end Joint;