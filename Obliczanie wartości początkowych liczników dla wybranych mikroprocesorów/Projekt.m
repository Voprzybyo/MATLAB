% Projekt z Technik Obliczeniowych
%
% Temat 33
% Obliczanie warto�ci pocz�tkowych licznik�w dla wybranych mikroprocesor�w
% przy zadanej cz�stotliwo�ci MCLK
%
% Zesp�: Przyby�o Wojciech, Nowak Artur
%
% Luty 2019

a=0; % Zmienna za pomoc� kt�rej b�dzie mo�na wykonywa� program wielokrotnie
Powitanie() %Kr�tkie powitanie u�ytkownika 
while (a~=99) %P�tla pozwalaj�ce na wielokrotne wykonywanie programu

    Wybor_dzialania() %Wybor pomiedzy odmierzaniem czasu a wyznaczaniem pr�dko�ci transmisji
    wybor_dzialania=input(' ') %Podanie z klawiatury wyboru
    switch wybor_dzialania 
        
        case 0 %Wybor ustalenia stanu pocz�tkowego do odmierzenia czasu
            Wybor_licznika() %Informacje o wyborze po�adanego licznika
            wybor_licznika=input(' '); %Podanie z klawiatury wyboru licznika
            switch wybor_licznika
                case 0
                    Czas_AT89LP52_Liczniki_01_Mode_0() %Wywo�anie funkcji z obliczeniami dla licznika 13-bitowego
                case 1    
                    Czas_AT89LP52_Liczniki_01_Mode_1() %Wywo�anie funkcji z obliczeniami dla licznika 16-bitowego
            end
        
        case 1 %Wybor ustalenia stanu pocz�tkowego do wyznaczenia pr�dko�ci trnasmisji
            Wybor_transmisji() %Informacje o wyborze po�adanego licznika
            wybor_transmisji=input(' '); %Podanie z klawiatury wyboru licznika
            switch wybor_transmisji
                case 0
                    Transmisja_AT89LP52_Licznik_Mode_0() %Wywo�anie funkcji z obliczeniami dla licznika 13-bitowego
                case 1    
                    Transmisja_AT89LP52_Licznik_Mode_1() %Wywo�anie funkcji z obliczeniami dla licznika 16-bitowego
            end
        case 99 %Wyj�cie z programu
            a=99;
    
    end
end 