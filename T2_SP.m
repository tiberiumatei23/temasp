%Numar de ordine = 15
%Semnal Dreptunghiular
%Durata semnalelor D (sec) = 15
D = 15;
P = 40;
N = 50;
rez = P / 100;
W0 = 2*pi / P;   %Pulsatia
t = (-2 * P) : rez : (2 * P);  %rezolutia temporara
coef = zeros(1,N);   
vect = zeros(1,N);             
x = square( W0 * t, D); %Semnalul initial de tip dreptunghiular
x_init = @(t,k) square( W0 * t, D).*exp( -1j * k * W0 * t); 
x_rec = 0;   
c = (1 / P) * integral(@(t) x_init(t,0),0,P);   
for n = 1:50   
    coef(n) = (1 / P) * integral(@(t) x_init(t,n - 25 ),0,P);  
    x_rec = x_rec + coef(n) * exp( 1j * (n - 25) * W0 * t);  
end                                                                               
figure(1);    
subplot(2,1,1);
plot(t, x_rec, t, x,'r');
title('Semnalul dreptunghiular inital si reconstruit');
hold on;
vect(1) = abs(c);   
for n = 1:N
      vect(n+1) = 2 * abs(coef(n)); 
end
subplot(2,1,2);    
stem([0:N] * W0, vect,'b'); 
title('Spectrul semnalului dreptunghiular');

%Conform teoriei seriilor Fourier, orice semnal periodic poate fi aproximat printr-o suma
%de sinusuri si cosinusuri de frecvente diferite si coeficienti diferiti.