t=1:1:180;
d=1:40:180;

y = pulstran(t,d,'rectpuls',1/180);
stem(y);