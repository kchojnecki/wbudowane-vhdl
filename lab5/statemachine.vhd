
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity statemachine is
  port(
	clk:     in std_logic;
	pusher:  in std_logic;
  reset:  in std_logic;
	driver : out std_logic_vector(1 downto 0) := "00"
  );

end statemachine;

architecture Flow of statemachine is
  type stan is (S0, S1, S2, S3);
  signal stan_teraz : stan := S0;
  signal stan_potem : stan := S0;
begin

-- state_advance: process(clk)
-- begin
--   if rising_edge(clk) then
--     if pusher = '1' then
--      stan_teraz <= stan_potem;
-- 	 end if;
--   end if;
-- end process;

state_advance: process(clk, reset)
begin
  if(reset = '0') then
    if rising_edge(clk) then
      if pusher = '1' and stan_teraz = S3 then
        stan_teraz <=S1;
      end if;
      if pusher = '1' then
       stan_teraz <= stan_potem;
  	 end if;
      if pusher = '0' and stan_teraz = S2 then
        stan_teraz <=S0;
      end if;
     else
       stan_teraz <= S0;
     end if;
  end if;
end process;

next_state: process(stan_teraz)
begin

   case stan_teraz is
     when S0 =>
				stan_potem <= S1;
				driver <= "00";
	  when S1 =>
				stan_potem <= S2;
				driver <= "01";
	  when S2 =>
				stan_potem <= S3;
				driver <= "10";
	  when S3 =>
				stan_potem <= S1;
				driver <= "11";
   end case;
end process;

end Flow;