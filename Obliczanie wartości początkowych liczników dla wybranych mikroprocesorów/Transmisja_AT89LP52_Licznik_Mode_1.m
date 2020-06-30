function [] = Transmisja_AT89LP52_Licznik_Mode_1()

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%Komentarz

disp(' ')
disp('Licznik 1 mikroprocesora AT89LP52 jest licznikiem 16-bitowym')
disp('Cykl maszynowy mikroprocesora AT89LP52 wynosi 1,6,12 takt�w zegara')
disp('Mikroprocesor AT89LP52 mo�e taktowa� z maksymaln� cz�stotliwo�ci� 20 MHz')
disp('Cz�stotliwo�� zegara pomocnicznego mikroprocesorwa wynosi 1,8432 MHz')
disp(' ')
disp('Prosze wybra� czy pos�u�ymy si� zegarem wewn�trznym: ')
disp('0 - Nie')
disp('1 - Tak')

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%Wybor zegara, czestotliwosci i czasu + ograniczne


wybor_zegara=input(' ')

wyjscie_z_petli=1; %zmienna umo�liwiaj�ca ponowne wykonanie p�tli przy b��dnym podaniu warto�ci przez u�ytkownika
while(wyjscie_z_petli~=99) %p�tla umo�liwiaj�ca wyj�cie z p�tli 
switch wybor_zegara 
    case 0  
        disp(' ')
        wyjscie_z_petli_1=1; 
        while(wyjscie_z_petli_1~=101) 
        czestotliwosc=input('Prosze podac czestotliwosc: ');
        if (czestotliwosc>20e6)
            disp('Podano zbyt du�� cz�stotliwo�� dla mikroprocesora tego typu')
            disp('Prosze podac czestotliwo�� mniejsz� ni� 20MHz')
            wyjscie_z_petli_1=1;
        elseif (czestotliwosc<=20e6)
            wyjscie_z_petli_1=101;
        end
        end
        liczba_bodow=input('Prosze podac pr�dko�� transmiji w Bodach na sekunde: ');
        wyjscie_z_petli=99
    case 1
        disp(' ')
        czestotliwosc=1843200
        liczba_bodow=input('Prosze podac pr�dko�� transmisji w Bodach na sekunde: ');
        wyjscie_z_petli=99
    otherwise 
        disp('Nalezy poda� 0 lub 1')
        wyjscie_z_petli=1
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%Wyb�r flagi

disp(' ')
disp('Prosze wybrac typ flagi X: ')
disp('0 - Flaga X0, 1 cykl maszynowy to 12 cykli zegara')
disp('1 - Flaga X1, 1 cykl maszynowy to 6 cykli zegara')
disp('2 - Flaga X2, 1 cykl maszynowy to 1 cykli zegara')


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


wyjscie_z_petli=1;
while(wyjscie_z_petli~=99)
wybor_flagi_X=input(' ')
switch wybor_flagi_X
    case 0  
         flaga_X=12;
         wyjscie_z_petli=99
    case 1
         flaga_X=6;
         wyjscie_z_petli=99
    case 2     
         flaga_X=1;
         wyjscie_z_petli=99
    otherwise 
        disp('Nalezy poda� 0, 1 lub 2')
        wyjscie_z_petli=1
end
end


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%Obliczenia
cykl_maszynowy=czestotliwosc/flaga_X;
cykl_maszynowy_w_sekundach=1/cykl_maszynowy;
overflow_timer_1_SMOD_0=(liczba_bodow.*32);
overflow_timer_1_SMOD_1=(liczba_bodow.*32)./2;
overflow_timer_1_SMOD_0_w_sekundach=1/overflow_timer_1_SMOD_0;
overflow_timer_1_SMOD_1_w_sekundach=1/overflow_timer_1_SMOD_1;

stan_poczatkowy_licznika_dec_SMOD_0=floor(65537-floor(overflow_timer_1_SMOD_0_w_sekundach/cykl_maszynowy_w_sekundach));
stan_poczatkowy_licznika_dec_SMOD_1=floor(65537-floor(overflow_timer_1_SMOD_1_w_sekundach/cykl_maszynowy_w_sekundach));

zmienna_kontrolna=0;
if(stan_poczatkowy_licznika_dec_SMOD_0>=0 && stan_poczatkowy_licznika_dec_SMOD_1>=0)
stan_poczatkowy_licznika_hex_SMOD_0=dec2hex(stan_poczatkowy_licznika_dec_SMOD_0);
stan_poczatkowy_licznika_hex_SMOD_1=dec2hex(stan_poczatkowy_licznika_dec_SMOD_1);
Sprawdzenie_SMOD_0_w_sekundach=(65537-stan_poczatkowy_licznika_dec_SMOD_0)*cykl_maszynowy_w_sekundach;
Sprawdzenie_SMOD_1_w_sekundach=(65537-stan_poczatkowy_licznika_dec_SMOD_1)*cykl_maszynowy_w_sekundach;
Blad_SMOD0=abs(overflow_timer_1_SMOD_0_w_sekundach-Sprawdzenie_SMOD_0_w_sekundach)/overflow_timer_1_SMOD_0_w_sekundach;
Blad_SMOD1=abs(overflow_timer_1_SMOD_1_w_sekundach-Sprawdzenie_SMOD_1_w_sekundach)/overflow_timer_1_SMOD_1_w_sekundach;
zmienna_kontrolna=1;
end
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%Wynik


disp(' ')
disp('--------------------------------------------------------------------- ')
disp(' ')



wynik=[('Cykl maszynowy w sekundach wynosi: '), num2str(cykl_maszynowy_w_sekundach)];
disp(wynik)

if(stan_poczatkowy_licznika_dec_SMOD_0<0 || stan_poczatkowy_licznika_dec_SMOD_1<0)
    disp('Nie mo�na wykona� oblicze�. Najprawdopodobniej zby ma�a ilo�� bod�w na sekund� w relacji do cz�stotliwo�ci')
end

if(cykl_maszynowy_w_sekundach>overflow_timer_1_SMOD_0_w_sekundach)
    disp('Nie mo�na wyznaczy� pr�dko�ci transmisji przy konfiguracji SMOD0 poniewa� czas prze�adowania licznika jest mniejszy od cyklu maszynowego')
end

if(cykl_maszynowy_w_sekundach>overflow_timer_1_SMOD_0_w_sekundach)
    disp('Nie mo�na wyznaczy� pr�dko�ci transmisji przy konfiguracji SMOD1 poniewa� czas prze�adowania licznika jest mniejszy od cyklu maszynowego')
end


if(cykl_maszynowy_w_sekundach<=overflow_timer_1_SMOD_0_w_sekundach && zmienna_kontrolna==1)
wynik=[('Czas prze�adowania licznika przy SMOD0 ma wyniesc: '), num2str(overflow_timer_1_SMOD_0_w_sekundach)];
disp(wynik)
wynik=[('Stan pocz�tkowy licznika 1 przy SMOD0 w systemie dziesi�tnym: '), num2str(stan_poczatkowy_licznika_dec_SMOD_0)];
disp(wynik)
wynik=[('Stan pocz�tkowy licznika 1 przy SMOD0 w systemie heksadecymalnym: '), num2str(stan_poczatkowy_licznika_hex_SMOD_0)];
disp(wynik)
wynik=[('Rzeczywisty czas prze�adowania licznika: '), num2str(Sprawdzenie_SMOD_0_w_sekundach)];
disp(wynik)
wynik=[('Blad generacji: '), num2str(Blad_SMOD0)];
disp(wynik)
if(Blad_SMOD0<0.03)
    disp('Realizacja ma szanse powodzenia')
else 
    disp('Przekroczono 3% prog')
end
end

if(cykl_maszynowy_w_sekundach<=overflow_timer_1_SMOD_1_w_sekundach && zmienna_kontrolna==1)
wynik=[('Czas prze�adowania licznika przy SMOD1 ma wyniesc: '), num2str(overflow_timer_1_SMOD_1_w_sekundach)];
disp(wynik)
wynik=[('Stan pocz�tkowy licznika 1 przy SMOD1 w systemie dziesi�tnym: '), num2str(stan_poczatkowy_licznika_dec_SMOD_1)];
disp(wynik)
wynik=[('Stan pocz�tkowy licznika 1 przy SMOD1 w systemie heksadecymalnym: '), num2str(stan_poczatkowy_licznika_hex_SMOD_1)];
disp(wynik)
wynik=[('Rzeczywisty czas prze�adowania licznika: '), num2str(Sprawdzenie_SMOD_1_w_sekundach)];
disp(wynik)
wynik=[('Blad generacji: '), num2str(Blad_SMOD1)];
disp(wynik)
if(Blad_SMOD1<0.03)
    disp('Realizacja ma szanse powodzenia')
else 
    disp('Przekroczono 3% prog')
end 
end

disp(' ')
disp('--------------------------------------------------------------------- ')
disp(' ')
disp(' ')


disp('Prosze wcisnac jakikolwiek klawisz by powrocic do poprzedniego ekranu')

disp(' ')
disp(' ')
disp('--------------------------------------------------------------------- ')
disp(' ')
disp(' ')

pause;
end

