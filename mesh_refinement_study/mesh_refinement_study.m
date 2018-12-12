close all; clear all;

precursor_50 = csvread('precursor_concentration_N=50_dt=0.01.csv');
flux_50 = csvread('flux_N=50_dt=0.01.csv');
current_50 = csvread('current_N=50_dt=0.01.csv');

precursor_100 = csvread('precursor_concentration_N=100_dt=0.005.csv');
flux_100 = csvread('flux_N=100_dt=0.005.csv');
current_100 = csvread('current_N=100_dt=0.005.csv');

precursor_200 = csvread('precursor_concentration_N=200_dt=0.0025.csv');
flux_200 = csvread('flux_N=200_dt=0.0025.csv');
current_200 = csvread('current_N=200_dt=0.0025.csv');

precursor_500 = csvread('precursor_concentration_N=500_dt=0.001.csv');
flux_500 = csvread('flux_N=500_dt=0.001.csv');
current_500 = csvread('current_N=500_dt=0.001.csv');

precursor_1000 = csvread('precursor_concentration_N=1000_dt=0.0005.csv');
flux_1000 = csvread('flux_N=1000_dt=0.0005.csv');
current_1000 = csvread('current_N=1000_dt=0.0005.csv');

mesh_50 = 0:pi/50:pi;
mesh_100 = 0:pi/100:pi; 
mesh_200 = 0:pi/200:pi; 
mesh_500 = 0:pi/500:pi;
mesh_1000 = 0:pi/1000:pi;

exact = @(x) sin(x)*exp(1.0);

for index = 1:50
   exact_50(index) = mean(exact(mesh_50(index):0.000001:mesh_50(index+1)));  
end

for index = 1:100
   exact_100(index) = mean(exact(mesh_100(index):0.000001:mesh_100(index+1))); 
end

for index = 1:200
   exact_200(index) = mean(exact(mesh_200(index):0.000001:mesh_200(index+1))); 
end

for index = 1:500
   exact_500(index) = mean(exact(mesh_500(index):0.000001:mesh_500(index+1))); 
end

for index = 1:1000
   exact_1000(index) = mean(exact(mesh_1000(index):0.000001:mesh_1000(index+1)));  
end

% Precursor error
e_precur(1) = norm(exact_50'-precursor_50,inf);
e_precur(2) = norm(exact_100'-precursor_100,inf);
e_precur(3) = norm(exact_200'-precursor_200,inf);
e_precur(4) = norm(exact_500'-precursor_500,inf);
e_precur(5) = norm(exact_1000'-precursor_1000,inf);


% Flux error
e_flux(1) = norm(2*exact_50'-flux_50,inf);
e_flux(2) = norm(2*exact_100'-flux_100,inf);
e_flux(3) = norm(2*exact_200'-flux_200,inf);
e_flux(4) = norm(2*exact_500'-flux_500,inf);
e_flux(5) = norm(2*exact_1000'-flux_1000,inf);

% current error
e_current(1) = norm(current_50,inf);
e_current(2) = norm(current_100,inf);
e_current(3) = norm(current_200,inf);
e_current(4) = norm(current_500,inf);
e_current(5) = norm(current_1000,inf);


h = [pi/50,pi/100,pi/200, pi/500, pi/1000];
%h = [pi/50,pi/100,pi/200];
for j=2:length(h), alpha_dnpc(j)=(log(e_precur(j))-log(e_precur(j-1)))/(log(h(j))-log(h(j-1)));end
for j=2:length(h), alpha_flux(j)=(log(e_flux(j))-log(e_flux(j-1)))/(log(h(j))-log(h(j-1)));end
for j=2:length(h), alpha_current(j)=(log(e_current(j))-log(e_current(j-1)))/(log(h(j))-log(h(j-1)));end

alpha_dnpc
alpha_flux
alpha_current

loglog(h,e_precur,'*-',h,e_flux,'o-',h,e_current,'gx-',h,10^(-0.5)*h,'k-'); hold on;
grid on;


legend('Delayed Neutron Precursor Concentration', 'Flux', 'Current', 'Linear')
xlabel('$h$','Interpreter','LaTex');
ylabel('$||e||_\infty$','Interpreter','LaTex');
axis([.002, 1E-1, 1E-4, 1E0])
