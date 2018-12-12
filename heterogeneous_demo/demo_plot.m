close all; clear all;

precursor = csvread('precursor_concentration_test_input.yaml_N=70_dt=5e-05.csv');
flux = csvread('flux_test_input.yaml_N=70_dt=5e-05.csv');

x = linspace(0.075, 10.5-0.075,70); 

subplot(1,2,1)
grid on; hold on;
for i = 1:6
   
    plot(x, flux(:,i),'-x')
    
end
xlim([0,10.5]); ax = gca; ax.YAxis.Exponent = 3;
ylabel('neutron flux $\left[\frac{1}{cm^2s}\right]$', 'Interpreter', 'latex')
xlabel('position $\left[cm\right]$', 'Interpreter', 'latex')
subplot(1,2,2); grid on; hold on;
for i = 1:6
   
    plot(x, precursor(:,i),'-x')
    
end
xlim([0,10.5])
ylabel('precursor concentration $\left[\frac{1}{cm^3}\right]$', 'Interpreter', 'latex')
xlabel('position $\left[cm\right]$', 'Interpreter', 'latex')
legend('t = 0','t = 5.0E-5', 't = 1.0E-4', 't = 1.5E-4', 't = 2.0E-4', 't = 2.5E-4', 'Orientation', 'vertical');


