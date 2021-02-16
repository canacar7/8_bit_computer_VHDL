library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use IEEE.std_logic_unsigned.all;

entity proram_memory is
port( 	clk : in std_logic;
		adress : in std_logic_vector(7 downto 0);
		data_out : out std_logic_vector(7 downto 0)
);
end proram_memory;

architecture arch of proram_memory is
--rom da cal�smas� gereken komutlar tan�mlanacak
--load and store
constant LDA_IMM : std_logic_vector (7 downto 0) := x"86";
constant LDA_DIR : std_logic_vector (7 downto 0) := x"87";
constant LDB_IMM : std_logic_vector (7 downto 0) := x"88";
constant LDB_DIR : std_logic_vector (7 downto 0) := x"89";
constant STA_DIR : std_logic_vector (7 downto 0) := x"96";
constant STB_DIR : std_logic_vector (7 downto 0) := x"97";

--data maniplations
constant ADD_AB : std_logic_vector (7 downto 0) := x"42";
constant SUB_AB : std_logic_vector (7 downto 0) := x"43";
constant AND_AB : std_logic_vector (7 downto 0) := x"44";
constant OR_AB : std_logic_vector (7 downto 0) := x"45";
constant INCA : std_logic_vector (7 downto 0) := x"46";
constant INCB : std_logic_vector (7 downto 0) := x"47";
constant DECA : std_logic_vector (7 downto 0) := x"48";
constant DECB : std_logic_vector (7 downto 0) := x"49";

--branches
constant BRA : std_logic_vector (7 downto 0) := x"20";
constant BMI : std_logic_vector (7 downto 0) := x"21";
constant BPL : std_logic_vector (7 downto 0) := x"22";
constant BEQ : std_logic_vector (7 downto 0) := x"23";
constant BNE : std_logic_vector (7 downto 0) := x"24";
constant BVS : std_logic_vector (7 downto 0) := x"25";
constant BVC : std_logic_vector (7 downto 0) := x"26";
constant BCS : std_logic_vector (7 downto 0) := x"27";
constant BCC : std_logic_vector (7 downto 0) := x"28";


--rom bellegii tan�mlamam laz�m
type rom_type is array (0 to 127) of std_logic_vector(7 downto 0); 
constant ROM: rom_type :=(
					
0 => LDA_DIR, 		--OPERAND A REG�STIRANA YUKLEME YAP
1 => x"AA", 		-- X"AA" SAYISINI YUKLE
2 => STA_DIR, 		--A REG�STRINA SAYIYI KAYDET
3 => x"80",   		--kaydedilcek adress bilgisi
4 => BRA,     		--kay�t yapt�ktan sonra atlma i�lemi 
5 => x"00",   		--atl�cam�z program saya�c� 0 olsun yani progra en ba�a gidip tekrar ba�las�n
others => x"00" 	--digerelemanlar bo� olsun 
					--test bench yaparken komutlar� buraya yaz�yoruz komutlar burdan okunur
);
--enable sinyali dogru adrees gelip gelmedigi kontrol ama�l�
signal EN : std_logic;

--b�t�n gerekli sabit ler ve sinyaler �retildi �imdi  mimari tasar�m�
begin
process(adress)	
begin				--dogru adress tespiti yap�ld�	
	if(adress >= x"00" and adress <= x"7F") then
		EN <= '1';
	else  
		EN <= '0';
	end if;
end process;

process(clk)
begin
	if(rising_edge(clk)) then
		if(EN = '1') then
			data_out <= ROM(to_integer(unsigned(adress)));
		end if;
	end if;		
end process;
end architecture;











