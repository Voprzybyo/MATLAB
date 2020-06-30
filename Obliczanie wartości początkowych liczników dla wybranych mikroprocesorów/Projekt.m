% Projekt z Technik Obliczeniowych
%
% Temat 33
% Obliczanie wartoœci pocz¹tkowych liczników dla wybranych mikroprocesorów
% przy zadanej czêstotliwoœci MCLK
%
% Zespó³: Przyby³o Wojciech, Nowak Artur
%
% Luty 2019

a=0; % Zmienna za pomoc¹ której bêdzie mo¿na wykonywaæ program wielokrotnie
Powitanie() %Krótkie powitanie u¿ytkownika 
while (a~=99) %Pêtla pozwalaj¹ce na wielokrotne wykonywanie programu

    Wybor_dzialania() %Wybor pomiedzy odmierzaniem czasu a wyznaczaniem prêdkoœci transmisji
    wybor_dzialania=input(' ') %Podanie z klawiatury wyboru
    switch wybor_dzialania 
        
        case 0 %Wybor ustalenia stanu pocz¹tkowego do odmierzenia czasu
            Wybor_licznika() %Informacje o wyborze po¿adanego licznika
            wybor_licznika=input(' '); %Podanie z klawiatury wyboru licznika
            switch wybor_licznika
                case 0
                    Czas_AT89LP52_Liczniki_01_Mode_0() %Wywo³anie funkcji z obliczeniami dla licznika 13-bitowego
                case 1    
                    Czas_AT89LP52_Liczniki_01_Mode_1() %Wywo³anie funkcji z obliczeniami dla licznika 16-bitowego
            end
        
        case 1 %Wybor ustalenia stanu pocz¹tkowego do wyznaczenia prêdkoœci trnasmisji
            Wybor_transmisji() %Informacje o wyborze po¿adanego licznika
            wybor_transmisji=input(' '); %Podanie z klawiatury wyboru licznika
            switch wybor_transmisji
                case 0
                    Transmisja_AT89LP52_Licznik_Mode_0() %Wywo³anie funkcji z obliczeniami dla licznika 13-bitowego
                case 1    
                    Transmisja_AT89LP52_Licznik_Mode_1() %Wywo³anie funkcji z obliczeniami dla licznika 16-bitowego
            end
        case 99 %Wyjœcie z programu
            a=99;
    
    end
end 