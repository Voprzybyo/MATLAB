function []=Czas_AT89LP52_Licznik_01_Mode1()

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%Komentarz

disp(' ')
disp('Liczniki 0 i 1 mikroprocesora AT89LP52 tworz¹ licznik 16-bitowy')
disp('Cykl maszynowy mikroprocesora AT89LP52 wynosi 1,6,12 taktów zegara')
disp('Mikroprocesor AT89LP52 mo¿e taktowaæ z maksymaln¹ czêstotliwoœci¹ 20 MHz')
disp('Czêstotliwoœæ zegara pomocnicznego mikroprocesorwa wynosi 1,8432 MHz')
disp(' ')
disp('Prosze wybraæ czy pos³u¿ymy siê zegarem wewnêtrznym: ')
disp('0 - Nie')
disp('1 - Tak')

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%Wybor zegara,czestotliwosci i czasu


wybor_zegara=input(' ')

wyjscie_z_petli=1;
while(wyjscie_z_petli~=99)
switch wybor_zegara
    case 0  
        disp(' ')
        wyjscie_z_petli_1=1;
        while(wyjscie_z_petli_1~=101) 
        czestotliwosc=input('Prosze podac czestotliwosc: ');
        if (czestotliwosc>20e6)
            disp('Podano zbyt du¿¹ czêstotliwoœæ dla mikroprocesora tego typu')
            disp('Prosze podac czestotliwoœæ mniejsz¹ ni¿ 20MHz')
            wyjscie_z_petli_1=1;
        elseif (czestotliwosc<=20e6)
            wyjscie_z_petli_1=101;
        end
        end
        czas=input('Prosze podac czas: ');
        wyjscie_z_petli=99;
    case 1
        disp(' ')
        czestotliwosc=1843200
        czas=input('Prosze podac czas: ');
        wyjscie_z_petli=99;
    otherwise 
        disp('Nalezy podaæ 0 lub 1')
        wyjscie_z_petli=1;
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%Wybór flagi

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
         wyjscie_z_petli=99;
    case 1
         flaga_X=6;
         wyjscie_z_petli=99;
    case 2     
         flaga_X=1;
         wyjscie_z_petli=99;
    otherwise 
        disp('Nalezy podaæ 0, 1 lub 2')
        wyjscie_z_petli=1;
end
end


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%Obliczenia

        
cykl_maszynowy=floor(czestotliwosc/flaga_X);
cykl_maszynowy_w_sekundach=1/cykl_maszynowy;
time_out_period=65536/cykl_maszynowy;

if(czas>time_out_period)
liczba_flag_minus_jeden=floor(czas/time_out_period);
czas=czas-liczba_flag_minus_jeden*time_out_period;
    
    if((cykl_maszynowy_w_sekundach/czas)>0.00001 && mod(czas,cykl_maszynowy_w_sekundach)~=0  )
    proporcja=65536*czas/time_out_period;
    stan_poczatkowy_licznika_dec=65536-ceil(proporcja)+1;
    stan_poczatkowy_licznika_hex=dec2hex(stan_poczatkowy_licznika_dec);
    spr=((65536-stan_poczatkowy_licznika_dec)+1)*cykl_maszynowy_w_sekundach;
    suma=spr+time_out_period*liczba_flag_minus_jeden;
    laczna_liczba_flag=liczba_flag_minus_jeden+1;

    elseif(czas==0)
    proporcja=65536*czas/time_out_period;
    stan_poczatkowy_licznika_dec=0;
    stan_poczatkowy_licznika_hex=dec2hex(stan_poczatkowy_licznika_dec);
    spr=((65536-stan_poczatkowy_licznika_dec)+1)*cykl_maszynowy_w_sekundach;
    suma=spr+time_out_period*liczba_flag_minus_jeden;
    laczna_liczba_flag=liczba_flag_minus_jeden+1;

    else
    proporcja=65536*czas/time_out_period;
    stan_poczatkowy_licznika_dec=65536-proporcja+1;
    stan_poczatkowy_licznika_hex=dec2hex(stan_poczatkowy_licznika_dec);
    spr=((65536-stan_poczatkowy_licznika_dec)+1)*cykl_maszynowy_w_sekundach;
    suma=spr+time_out_period*liczba_flag_minus_jeden;
    laczna_liczba_flag=liczba_flag_minus_jeden+1;

    end
    

elseif((cykl_maszynowy_w_sekundach/czas)>0.00001 && mod(czas,cykl_maszynowy_w_sekundach)~=0  )
liczba_flag_minus_jeden=floor(czas/time_out_period);
proporcja=65536*czas/time_out_period;
Blad=1-(proporcja/ceil(proporcja));
stan_poczatkowy_licznika_dec=65536-ceil(proporcja)+1;
stan_poczatkowy_licznika_hex=dec2hex(stan_poczatkowy_licznika_dec);
spr=((65536-stan_poczatkowy_licznika_dec)+1)*cykl_maszynowy_w_sekundach;
laczna_liczba_flag=liczba_flag_minus_jeden+1;


else    
liczba_flag_minus_jeden=floor(czas/time_out_period);    
proporcja=65536*czas/time_out_period;
stan_poczatkowy_licznika_dec=65536-proporcja+1;
stan_poczatkowy_licznika_hex=dec2hex(stan_poczatkowy_licznika_dec);
spr=((65536-stan_poczatkowy_licznika_dec)+1)*cykl_maszynowy_w_sekundach;
laczna_liczba_flag=liczba_flag_minus_jeden+1;

end



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%Wynik


disp(' ')
disp('--------------------------------------------------------------------- ')
disp(' ')

wynik=[('Czas trwania cyklu maszynowego: '), num2str(cykl_maszynowy_w_sekundach)];
disp(wynik)
wynik=[('Stan pocz¹tkowy licznika w systemie dziesiêtnym: '), num2str(stan_poczatkowy_licznika_dec)];
disp(wynik)
wynik=[('Stan pocz¹tkowy licznika w systemie heksadecymalnym: '), num2str(stan_poczatkowy_licznika_hex)];
disp(wynik)
wynik=[('£¹czna liczba flag do odmierzenia czasu: '), num2str(laczna_liczba_flag)];
disp(wynik)
wynik=[('B³¹d odmierzenia czasu: '), num2str(Blad)];
disp(wynik)
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