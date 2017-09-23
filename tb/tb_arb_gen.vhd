------------------------------------------------------------------
-- Name	       : tb_arb_gen.vhd
-- Description : Testbench for generic arbiter
-- Designed by : Claudio Avi Chami - FPGA Site
-- Version     : 01
------------------------------------------------------------------
library ieee;
    use ieee.std_logic_1164.all;
    use ieee.std_logic_textio.all;
    use ieee.numeric_std.ALL;
    use std.textio.all;
    
entity tb_arb_gen is
end entity;

architecture test of tb_arb_gen is

  constant PERIOD     : time   := 20 ns;
  constant ARBITER_W  : natural := 4;

  signal clk       : std_logic := '0';
  signal rst       : std_logic := '1';
  signal busy      : std_logic := '0';
  signal req       : std_logic_vector(ARBITER_W-1 downto 0) := (others => '0');
  signal gnt       : std_logic_vector(ARBITER_W-1 downto 0);
  signal count     : unsigned(1 downto 0);
  signal endSim	 : boolean   := false;

  component arbiter_gen  is
    generic (
      ARBITER_W		: natural := 4
    );
    port (
      clk: 		in std_logic;
      rst: 		in std_logic;
      
      -- inputs
      req:		in std_logic_vector(ARBITER_W-1 downto 0);
      busy:   in std_logic;
      
      -- outputs
      gnt:		out std_logic_vector(ARBITER_W-1 downto 0)
    );
  end component;
    

begin
  clk     <= not clk after PERIOD/2;
  rst     <= '0' after  PERIOD*10;

  -- 'busy' signal generation
  -- bus is busy during four clocks for each transaction
  busy_pr: process (rst, clk)
  begin
    if (rst = '1') then
      count  <= (others => '0');
    elsif (rising_edge(clk)) then
      if (unsigned(gnt) > 0 and count > 0) then
        busy   <= '1';
        count  <= count - 1;
      else
        busy   <= '0';
      end if;
      
      if (busy = '0') then
        count  <= (others => '1');
      end if;
    end if;
  end process busy_pr;
  
    
	-- Main simulation process
	process 
	begin
		req <= "0000";
	
		wait until (rst = '0');
		wait until (rising_edge(clk));

		wait until (rising_edge(clk));
		req <= "0100";
    wait until (busy = '1');
		for I in 0 to 1 loop
			wait until (rising_edge(clk));
		end loop;	
		req <= "0010";
    wait until (busy = '1');
		for I in 0 to 2 loop
			wait until (rising_edge(clk));
		end loop;	
		req <= "0001";
    wait until (busy = '1');
		for I in 0 to 2 loop
			wait until (rising_edge(clk));
		end loop;	
		req <= "0110";
    wait until (busy = '1');
		for I in 0 to 2 loop
			wait until (rising_edge(clk));
		end loop;	
		req <= "1101";
    wait until (busy = '1');
		for I in 0 to 3 loop
			wait until (rising_edge(clk));
		end loop;	
		req <= "1110";
    wait until (busy = '1');
		endSim  <= true;
  	wait until (rising_edge(clk));
	end	process;	
		
	-- End the simulation
	process 
	begin
		if (endSim) then
			assert false 
				report "End of simulation." 
				severity failure; 
		end if;
		wait until (rising_edge(clk));
	end process;	

    arb_inst : arbiter_gen
    generic map (
		ARBITER_W	 => ARBITER_W
	)
    port map (
        clk      => clk,
        rst	     => rst,
		
        req  	   => req,
        busy  	 => busy,
        gnt      => gnt
    );

end architecture;