within Dev.Interfaces;

connector ContactPort extends Dev.Interfaces.FramePort;
	/**
	 * Contact point relative coords in global frame
	 * i.e. vector from body masscenter to Contact point,
	 * resolved in the world frame.
	 */
	Real[3] point;
end ContactPort;