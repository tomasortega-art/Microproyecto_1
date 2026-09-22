 library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity divisor_1Hz is
    Port (
        clk_in  : in  STD_LOGIC; -- Reloj de entrada de la FPGA (ej. 50 MHz)
        reset   : in  STD_LOGIC; -- Reinicio asíncrono
        clk_out : out STD_LOGIC  -- Reloj de salida de 1 Hz
    );
end divisor_1Hz;

architecture Comportamental of divisor_1Hz is
    -- Constante para un reloj base de 50 MHz. 
    -- Alterna su estado cada 25,000,000 de ciclos para generar 1 Hz.
    constant MAX_COUNT : integer := 25000000;
    signal count : integer range 0 to MAX_COUNT := 0;
    signal clk_estado : STD_LOGIC := '0';
begin
    process(clk_in, reset)
    begin
        if reset = '1' then
            count <= 0;
            clk_estado <= '0';
        elsif rising_edge(clk_in) then
            if count = MAX_COUNT - 1 then
                count <= 0;
                clk_estado <= not clk_estado;
            else
                count <= count + 1;
            end if;
        end if;
    end process;
    
    clk_out <= clk_estado;
end Comportamental;