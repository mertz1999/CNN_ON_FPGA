----------------------------------------------------------------------------------
---                         Max-Pooling Layer 👀                                
--- Mertz.1400.2021
--- Desc: 
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

library work;
use work.cnn_types.all;

entity max_pooling is
    port(
        --- input ports
        clk          : in std_logic;
        pool_en      : in std_logic := '0';
        result_one   : in signed(13 downto 0);
        result_two   : in signed(13 downto 0);
        result_three : in signed(13 downto 0);
        result_four  : in signed(13 downto 0);
        
        -- output ports
        pooling_result_one   : out signed(13 downto 0);
        pooling_result_two   : out signed(13 downto 0);
        pooling_result_three : out signed(13 downto 0);
        pooling_result_four  : out signed(13 downto 0);
        pooling_result_en : out state

    );
end max_pooling;

architecture Behavioral of max_pooling is
    --- find max component
    component find_max
        port(
            max_en    : in state;
            Reg1      : in signed(13 downto 0);
            Reg2      : in signed(13 downto 0);
            Reg11     : in signed(13 downto 0);
            Reg12     : in signed(13 downto 0);
            max_value : out signed(13 downto 0) := (others => '0')
        );
    end component;
    --- Define Signals
    signal Reg1, Reg2, Reg3, Reg4, Reg5, Reg6, Reg7, Reg8, Reg9, Reg10, Reg11, Reg12 : signed(55 downto 0);

    --- Define Counters
    signal counter_8      : integer range 0 to 7  := 0;
    signal counter_12     : integer range 0 to 12 := 0;
    signal counter_8_sig  : std_logic := '0';
    signal counter_12_sig : std_logic := '1';

    --- Define States
    signal pr_state : state := V_nok;


begin

--- instanace find max for result one
find_max_for_result_one : find_max port map(
    max_en    => pr_state,
    reg1      => reg1(55 downto 42),
    reg2      => reg2(55 downto 42),
    reg11     => reg11(55 downto 42),
    reg12     => reg12(55 downto 42),
    max_value => pooling_result_one
);

--- instanace find max for result two
find_max_for_result_two : find_max port map(
    max_en    => pr_state,
    reg1      => reg1(41 downto 28),
    reg2      => reg2(41 downto 28),
    reg11     => reg11(41 downto 28),
    reg12     => reg12(41 downto 28),
    max_value => pooling_result_two
);

--- instanace find max for result three
find_max_for_result_three : find_max port map(
    max_en    => pr_state,
    reg1      => reg1(27 downto 14),
    reg2      => reg2(27 downto 14),
    reg11     => reg11(27 downto 14),
    reg12     => reg12(27 downto 14),
    max_value => pooling_result_three
);

--- instanace find max for result four
find_max_for_result_four : find_max port map(
    max_en    => pr_state,
    reg1      => reg1(13 downto 0),
    reg2      => reg2(13 downto 0),
    reg11     => reg11(13 downto 0),
    reg12     => reg12(13 downto 0),
    max_value => pooling_result_four
);


--- result enable
pooling_result_en <= pr_state;

--- shift register process
shift_reg : process(clk)
    begin
        if rising_edge(clk) then
            if pool_en = '1' then
                Reg1  <= result_one & result_two & result_three & result_four;
                Reg2  <= Reg1;
                Reg3  <= Reg2;
                Reg4  <= Reg3;
                Reg5  <= Reg4;
                Reg6  <= Reg5;
                Reg7  <= Reg6;
                Reg8  <= Reg7;
                Reg9  <= Reg8;
                Reg10 <= Reg9;
                Reg11 <= Reg10;
                Reg12 <= Reg11;
            end if;
        end if;
end process shift_reg;


--- decide based on Present State
core : process(pr_state, counter_12_sig, counter_8_sig, clk, pool_en)
    begin
        if rising_edge(clk) and pool_en = '1' then
            case pr_state is
                --- If present state become H_ok
                when H_ok => 
                    if counter_8_sig = '0' then
                        pr_state <= V_nok;
                    else 
                        pr_state <= H_nok;
                    end if;

                --- If present state become H_nok
                when H_nok =>
                    if counter_8_sig = '0' then
                        pr_state <= V_nok;
                    else
                        pr_state <= H_ok;
                    end if;
                
                --- If present state become V_nok
                when V_nok => 
                    if counter_12 = 11 then
                        pr_state <= H_ok;
                    end if;
            end case;
        end if;     
end process core;


--- Counter process
counter_evaluate : process(counter_12_sig, counter_8_sig, clk, pool_en)
    begin
        --- checking clock and being enable
        if rising_edge(clk) and pool_en = '1' then
            --- If counter 8 being enable
            if counter_8_sig = '1' then
                counter_8 <= counter_8 + 1;
                if counter_8 = 7 then
                    counter_8_sig <= '0';
                    counter_12_sig <= '1';
                    counter_8 <= 0;
                end if;
            --- if counter 12 being enable
            elsif  counter_12_sig = '1' then
                counter_12 <= counter_12 + 1;
                if counter_12 = 11 then
                    counter_12_sig <= '0';
                    counter_8_sig <= '1';
                    counter_12 <= 0;
                end if;
            end if;
        end if;
end process;

end Behavioral;

