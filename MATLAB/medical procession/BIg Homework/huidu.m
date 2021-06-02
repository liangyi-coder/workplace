%ª“∂»∏Ø ¥∫Õ≈Ú’Õ
A = aw;

B = [0 1 0 ;1 1 1;0 1 0];

A1 = imerode(A,B);
A2 = imerode(A1,B);
A3 = imerode(A2,B);

figure;
subplot(1,3,1); imshow(A1);
subplot(1,3,2); imshow(A2);
subplot(1,3,3); imshow(A3);

C1 = imdilate(A1,B);
C2 = imdilate(C1,B);
C3 = imdilate(A3,B);

figure;
subplot(1,3,1); imshow(C1);
subplot(1,3,2); imshow(C2);
subplot(1,3,3); imshow(C3);


