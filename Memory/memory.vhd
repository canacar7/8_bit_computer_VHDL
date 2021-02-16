library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use IEEE.std_logic_unsigned.all;

entity memory is
port(
	clk : in std_logic;
	rst : in std_logic;
	adress : in std_logic_vector(7 downto 0);
	data_in : in std_logic_vector(7 downto 0);
	write_en : in std_logic;
	
	port_in_00 : in std_logic_vector(7 downto 0);
	port_in_01 : in std_logic_vector(7 downto 0);
	port_in_02 : in std_logic_vector(7 downto 0);
	port_in_03 : in std_logic_vector(7 downto 0);
	port_in_04 : in std_logic_vector(7 downto 0);
	port_in_05 : in std_logic_vector(7 downto 0);
	port_in_06 : in std_logic_vector(7 downto 0);
	port_in_07 : in std_logic_vector(7 downto 0);
	port_in_08 : in std_logic_vector(7 downto 0);
	port_in_09 : in std_logic_vector(7 downto 0);
	port_in_10 : in std_logic_vector(7 downto 0);
	port_in_11 : in std_logic_vector(7 downto 0);
	port_in_12 : in std_logic_vector(7 downto 0);
	port_in_13 : in std_logic_vector(7 downto 0);
	port_in_14 : in std_logic_vector(7 downto 0);
	port_in_15 : in std_logic_vector(7 downto 0);
	
	
	--outputs
	data_out : out std_logic_vector(7 downto 0);
	
	port_out_00 : out std_logic_vector(7 downto 0);
	port_out_01 : out std_logic_vector(7 downto 0);
	port_out_02 : out std_logic_vector(7 downto 0);
	port_out_03 : out std_logic_vector(7 downto 0);
	port_out_04 : out std_logic_vector(7 downto 0);
	port_out_05 : out std_logic_vector(7 downto 0);
	port_out_06 : out std_logic_vector(7 downto 0);
	port_out_07 : out std_logic_vector(7 downto 0);
	port_out_08 : out std_logic_vector(7 downto 0);
	port_out_09 : out std_logic_vector(7 downto 0);
	port_out_10 : out std_logic_vector(7 downto 0);
	port_out_11 : out std_logic_vector(7 downto 0);
	port_out_12 : out std_logic_vector(7 downto 0);
	port_out_13 : out std_logic_vector(7 downto 0);
	port_out_14 : out std_logic_vector(7 downto 0);
	port_out_15 : out std_logic_vector(7 downto 0)
	);
end memory;	

architecture arch of memory is

--alt bloklar� tan�mlamam gereklidir
component proram_memory is
port( 	clk : in std_logic;
		adress : in std_logic_vector(7 downto 0);
		data_out : out std_logic_vector(7 downto 0)
);
end component;

component data_memory is
port( 	
        clk : in std_logic;
		adress : in std_logic_vector(7 downto 0);
		data_in : in std_logic_vector(7 downto 0);
		write_en : in std_logic;
		
		data_out : out std_logic_vector(7 downto 0)
);
end component;

component output_ports is
port( 	
		clk : in std_logic;
		rst : in std_logic;
		adress : in std_logic_vector(7 downto 0);
		data_in : in std_logic_vector(7 downto 0);
		write_en : in std_logic;
		
		port_out_00 : out std_logic_vector(7 downto 0);
		port_out_01 : out std_logic_vector(7 downto 0);
		port_out_02 : out std_logic_vector(7 downto 0);
		port_out_03 : out std_logic_vector(7 downto 0);
		port_out_04 : out std_logic_vector(7 downto 0);
		port_out_05 : out std_logic_vector(7 downto 0);
		port_out_06 : out std_logic_vector(7 downto 0);
		port_out_07 : out std_logic_vector(7 downto 0);
		port_out_08 : out std_logic_vector(7 downto 0);
		port_out_09 : out std_logic_vector(7 downto 0);
		port_out_10 : out std_logic_vector(7 downto 0);
		port_out_11 : out std_logic_vector(7 downto 0);
		port_out_12 : out std_logic_vector(7 downto 0);
		port_out_13 : out std_logic_vector(7 downto 0);
		port_out_14 : out std_logic_vector(7 downto 0);
		port_out_15 : out std_logic_vector(7 downto 0)
		
);
end component;

--mimariye girmeden �nce gerekli olan sinyalleride eklemeliyim
signal rom_out :  std_logic_vector(7 downto 0);
signal ram_out :  std_logic_vector(7 downto 0);

--mimariye ge�i�
begin
--tan�t�lan alt bloklar� dahil etmek
rom_u: proram_memory port map
(
	clk      => clk,
    adress   => adress,
    data_out => rom_out
);

ram_u : data_memory port map
(
clk      => clk,
adress   => adress,
data_in  => data_in,
write_en => write_en,  
data_out => ram_out
);	

output_u: output_ports port map
(
		clk      => clk,
		adress   => adress,
		data_in  => data_in,
		write_en => write_en, 
		rst      => rst,
		
		port_out_00 => port_out_00,
		port_out_01 => port_out_01,
		port_out_02 => port_out_02,
		port_out_03 => port_out_03,
		port_out_04 => port_out_04,
		port_out_05 => port_out_05,
		port_out_06 => port_out_06,
		port_out_07 => port_out_07,
		port_out_08 => port_out_08,
		port_out_09 => port_out_09,
		port_out_10 => port_out_10,
		port_out_11 => port_out_11,
		port_out_12 => port_out_12,
		port_out_13 => port_out_13,
		port_out_14 => port_out_14,
		port_out_15 => port_out_15

);
--giris sinyallerini tan�mlamam gereklidir
process(adress, rom_out, ram_out, port_in_00,port_in_01,port_in_02,port_in_03,port_in_04,
			port_in_05,port_in_06,port_in_07,port_in_08,port_in_09,port_in_10,
			port_in_11,port_in_12,port_in_13,port_in_14,port_in_15) 
begin
	if ( adress >= x"00" and adress >= x"7F") then
		data_out <= rom_out;
	elsif( adress >= x"80" and adress >= x"DF") then
		data_out <= ram_out;
	elsif (adress = x"F0") then
		data_out <= port_in_00;
	elsif (adress = x"F1") then
    	data_out <= port_in_01;
	elsif (adress = x"F2") then
		data_out <= port_in_00;
	elsif (adress = x"F3") then
    	data_out <= port_in_00;
	elsif (adress = x"F4") then
    	data_out <= port_in_00;
    elsif (adress = x"F5") then
    	data_out <= port_in_00;
	elsif (adress = x"F6") then
    	data_out <= port_in_00;
	elsif (adress = x"F7") then
    	data_out <= port_in_00;
	elsif (adress = x"F8") then
    	data_out <= port_in_00;
	elsif (adress = x"F9") then
		data_out <= port_in_00;
	elsif (adress = x"FA") then
		data_out <= port_in_00;
	elsif (adress = x"FB") then
		data_out <= port_in_00;
	elsif (adress = x"FC") then
		data_out <= port_in_00;
	elsif (adress = x"FD") then
		data_out <= port_in_00;
	elsif (adress = x"FE") then
		data_out <= port_in_00;
	elsif (adress = x"FF") then
		data_out <= port_in_00;
	else
		data_out <= x"00";
		
	end if;
end process;
end architecture;
