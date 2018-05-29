
N = size(temp,1);
map = cell(N,1);
tempp = temp;
for i = 1 : N
    or_v = unique(abs(temp{i}));
    or_v(or_v==0) = [];
    if(size(temp{i},1)~=1)
        new_v = (1 : 1 : length(or_v))';
    else
        new_v = (1 : 1 : length(or_v));
    end
    
    mmap = [new_v or_v];
    map(i) = mat2cell(mmap, size(mmap,1));
    
    for j = 1 : length(or_v)
        tempp{i,1}(temp{i,1} == or_v(j)) = new_v(j);
        tempp{i,1}(temp{i,1} == -or_v(j)) = -new_v(j);
    end
end
%tempp�������յĽ��
for i = 1 : N
    dlmwrite(['map',num2str(i), '.txt'],map(i),'delimiter',' ');%����д���ļ�
end
for i = 1 : N
    fileID= fopen(['part',num2str(i), '.cnf'],'w');
    fprintf(fileID,'p cnf %d %d\n',tempp{i,2},tempp{i,3});%д��̧ͷ
    fclose(fileID);
    dlmwrite(['part',num2str(i), '.cnf'],tempp(i,1),'-append','delimiter',' ');%����д���ļ�
end





