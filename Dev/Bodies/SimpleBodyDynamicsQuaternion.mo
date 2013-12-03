within Dev.Bodies;
model SimpleBodyDynamicsQuaternion extends BaseSimpleBodyDynamics;
	import Modelica.Mechanics.MultiBody.Frames;
	protected
      parameter Frames.Quaternions.Orientation Q_start = Frames.to_Q(R_start);
      Frames.Quaternions.Orientation Q(start = Q_start);
equation
      frame_a.R = Frames.from_Q(Q, Frames.Quaternions.angularVelocity2(Q, der(Q)));
      {0} = Frames.Quaternions.orientationConstraint(Q);
end SimpleBodyDynamicsQuaternion;