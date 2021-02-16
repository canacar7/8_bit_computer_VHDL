library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use IEEE.std_logic_unsigned.all;

entity data_memory is
port( 	
        clk : in std_logic;
		adress : in std_logic_vector(7 downto 0);
		data_in : in std_logic_vector(7 downto 0);
		write_en : in std_logic;
		
		data_out : out std_logic_vector(7 downto 0)
);
end data_memory;

architecture arch of data_memory is
																	--ram taype tanımlamalıyım
type ram_type is array(128 to 223) of std_logic_vector(7 downto 0);
signal RAM: ram_type:=(others => x"00");
signal EN : std_logic;             								--adress kontrolu icin

begin

process(adress)	
begin																--dogru adress tespiti yapıldı	
	if(adress >= x"80" and adress <= x"DF") then					--128 ve 223 
		EN <= '1';
	else  
		EN <= '0';
	end if;
end process;

process(clk)
begin
	if(rising_edge(clk)) then
		if(EN = '1' and write_en = '1') then	-- Yazma
			RAM(to_integer(unsigned(adress))) <= data_in;
		elsif(EN = '1' and write_en = '0') then	-- Okuma
			data_out <= RAM(to_integer(unsigned(adress)));
		end if;
	end if;
end process;

end architecture;
