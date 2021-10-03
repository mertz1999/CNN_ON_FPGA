----------------------------------------------------------------------------------
---                     Implement Classification Layer
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

library work;
use work.cnn_types.all;

entity main_class is
    port(
        --- Input ports
        clk : in std_logic;
        feature_result_one   : in signed(13 downto 0);
        feature_result_two   : in signed(13 downto 0);
        feature_result_three : in signed(13 downto 0);
        feature_result_four  : in signed(13 downto 0);
        feature_result_en    : in state;

        --- Output ports
        node_one    : out signed(21 downto 0) := (others => '0');
        node_two    : out signed(21 downto 0) := (others => '0');
        node_three  : out signed(21 downto 0) := (others => '0');
        node_four   : out signed(21 downto 0) := (others => '0')
    );
end main_class;

architecture Behavioral of main_class is
    --- BRAM of classifiation weight data
    COMPONENT class_weight
        PORT (
        clka  : IN STD_LOGIC;
        addra : IN STD_LOGIC_VECTOR(4 DOWNTO 0);
        douta : OUT STD_LOGIC_VECTOR(127 DOWNTO 0)
        );
    END COMPONENT;

    --- Define signals
    signal counter         : integer range 0 to 24 := 0;
    signal addra           : std_logic_vector(4 downto 0);
    signal weights         : std_logic_vector(127 downto 0):= (others => '0');
    signal node_one_buff   : signed(28 downto 0) := (others => '0');
    signal node_two_buff   : signed(28 downto 0) := (others => '0');
    signal node_three_buff : signed(28 downto 0) := (others => '0');
    signal node_four_buff  : signed(28 downto 0) := (others => '0');
begin

--- Instance of BRAM
addra <= std_logic_vector(to_unsigned(counter,5));
class_weight_ins : class_weight
  PORT MAP (
    clka  => clk,
    addra => addra,
    douta => weights
);

--- Process for crossing
counter_proc : Process(feature_result_en, counter, clk)
    begin
        if rising_edge(clk) then
            if feature_result_en = H_ok then
                --- Increase coutner value
                counter <= counter + 1;
                --- DataCrossWeight 
                node_one_buff   <= node_one_buff +
                                resize(feature_result_one   * signed(weights(127 downto 120)),29) +
                                resize(feature_result_two   * signed(weights(95 downto 88)),29)   +
                                resize(feature_result_three * signed(weights(63 downto 56)),29)   +
                                resize(feature_result_four  * signed(weights(31 downto 24)),29);
                node_two_buff   <= node_two_buff +
                                resize(feature_result_one   * signed(weights(119 downto 112)),29) +
                                resize(feature_result_two   * signed(weights(87 downto 80)),29)   +
                                resize(feature_result_three * signed(weights(55 downto 48)),29)   +
                                resize(feature_result_four  * signed(weights(23 downto 16)),29);
                node_three_buff <= node_three_buff +
                                resize(feature_result_one   * signed(weights(111 downto 104)),29) +
                                resize(feature_result_two   * signed(weights(79 downto 72)),29)   +
                                resize(feature_result_three * signed(weights(47 downto 40)),29)   +
                                resize(feature_result_four  * signed(weights(15 downto 8)),29);
                node_four_buff  <= node_four_buff +
                                resize(feature_result_one   * signed(weights(103 downto 96)),29) +
                                resize(feature_result_two   * signed(weights(71 downto 64)),29)   +
                                resize(feature_result_three * signed(weights(39 downto 32)),29)   +
                                resize(feature_result_four  * signed(weights(7 downto 0)),29);
            end if;
        end if;
end process;

node_one   <= node_one_buff  (28 downto 7) + resize(to_signed(-18,7),22);
node_two   <= node_two_buff  (28 downto 7) + resize(to_signed(18,7),22);
node_three <= node_three_buff(28 downto 7) + resize(to_signed(0,7),22);
node_four  <= node_four_buff (28 downto 7) + resize(to_signed(-6,7),22);

end Behavioral;