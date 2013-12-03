within Dev.Surfaces;

model BaseSurface 
	import Modelica.Mechanics.MultiBody.Frames.resolve2;
	import Port = Dev.Interfaces.ContactPort;  
	  
	Port port;
	Real[3] contactPointRelativeLocal;
	Real[3] r;

equation 
	
	/**
	 * Surface equation in the form
	 * <expression>(r) = zeros(3);
	 * to be added in subclass.
	 */	
	contactPointRelativeLocal = resolve2(port.frame.R, port.point);
	contactPointRelativeLocal = r;
  
    if cardinality(port) > 0 then
		port.frame.f = zeros(3);
		port.frame.t = zeros(3);
    end if;
end BaseSurface;
