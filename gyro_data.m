clc;    %��������д���
clear;  %��չ�����

data = dlmread('29712noiceGyro.txt');         %���ı��ж�ȡ���ݣ���λ��deg/s�����ʣ�100Hz
data = data()*3600;    %��ȡ����Сʱ�����ݣ��� deg/s תΪ deg/h
%data = data(1:720000, 3:5)*3600;    %��ȡ����Сʱ�����ݣ��� deg/s תΪ deg/h
[A, B] = allan(data, 100, 100);     %��Allan��׼���100����������

loglog(A, B, 'o');                  %��˫��������ͼ
xlabel('time:sec');                 %���x���ǩ
ylabel('Sigma:deg/h');              %���y���ǩ
legend('X axis','Y axis','Z axis'); %��ӱ�ע
grid on;                            %���������
hold on;                            %ʹͼ�񲻱�����

C(1, :) = nihe(sqrt(A'), B(:, 1)', 2)';   %���
C(2, :) = nihe(sqrt(A'), B(:, 2)', 2)';
C(3, :) = nihe(sqrt(A'), B(:, 3)', 2)';

Q = abs(C(:, 1)) / sqrt(3);         %������������λ��arcsec
N = abs(C(:, 2)) / 60;	            %�Ƕ�������ߣ���λ��deg/h^0.5
Bs = abs(C(:, 3)) / 0.6643;	        %��ƫ���ȶ��ԣ���λ��deg/h
K = abs(C(:, 4)) * sqrt(3) * 60;	%���������ߣ���λ��deg/h/h^0.5
R = abs(C(:, 5)) * sqrt(2) * 3600;	%����б�£���λ��deg/h/h

fprintf('��������      X�᣺%f Y�᣺%f Z�᣺%f  ��λ��arcsec\n', Q(1), Q(2), Q(3));
fprintf('�Ƕ��������  X�᣺%f Y�᣺%f Z�᣺%f  ��λ��deg/h^0.5\n', N(1), N(2), N(3));
fprintf('��ƫ���ȶ���  X�᣺%f Y�᣺%f Z�᣺%f  ��λ��deg/h\n', Bs(1), Bs(2), Bs(3));
fprintf('����������    X�᣺%f Y�᣺%f Z�᣺%f  ��λ��deg/h/h^0.5\n', K(1), K(2), K(3));
fprintf('����б��      X�᣺%f Y�᣺%f Z�᣺%f  ��λ��deg/h/h\n', R(1), R(2), R(3));

D(:, 1) = C(1, 1)*sqrt(A).^(-2) + C(1, 2)*sqrt(A).^(-1) + C(1, 3)*sqrt(A).^(0) + C(1, 4)*sqrt(A).^(1) + C(1, 5)*sqrt(A).^(2);    %������Ϻ���
D(:, 2) = C(2, 1)*sqrt(A).^(-2) + C(2, 2)*sqrt(A).^(-1) + C(2, 3)*sqrt(A).^(0) + C(2, 4)*sqrt(A).^(1) + C(2, 5)*sqrt(A).^(2);
D(:, 3) = C(3, 1)*sqrt(A).^(-2) + C(3, 2)*sqrt(A).^(-1) + C(3, 3)*sqrt(A).^(0) + C(3, 4)*sqrt(A).^(1) + C(3, 5)*sqrt(A).^(2);

loglog(A, D);   %��˫��������ͼ
