%load files.
load('SVMTrain.mat')
load('SVMTest.mat')
%%code for training Adaboost.
% MaxIter = 100; % boosting iterations
% Train=Train';
% Test=Test';
% [pc,score,latent,tsquare] = princomp(Train(1:100,:));
% tranMatrix = pc(:,1:1000);
% Train=Train*tranMatrix;
% Test=Test*tranMatrix;
% TrainData   = Train';
% TrainLabels = Label;
% Test=Test';
% weak_learner = tree_node_w(10); % pass the number of tree splits to the constructor
% 
% % Step4: training with Gentle AdaBoost
% %[RLearners RWeights] = RealAdaBoost(weak_learner, TrainData, TrainLabels, MaxIter);
% 
% %Step5: training with Modest AdaBoost
% [MLearners MWeights] = ModestAdaBoost(weak_learner, TrainData, TrainLabels, MaxIter);
% 
% 
% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % %  
% % % % % % % % % % % % % % % % % Testing % % % % % % % % % % % % % % % % % %  
% % 
% 
% %ResultR = sign(Classify(RLearners, RWeights, Test));
% 
% ResultM = sign(Classify(MLearners, MWeights, Test));
% 
% % Step7: calculating error
% %ErrorR  = sum(TestLabel ~= ResultR) / length(Test)
% 
% ErrorM  = sum(TestLabel ~= ResultM) / length(Test)


%Codes for Training SVM
    Table=[];
    normTrain = Train - min(Train(:));
    normTrain = normTrain ./ max(normTrain(:));
    normTest = Test - min(Test(:));
    normTest = normTest ./ max(normTest(:));
    normTrain=normTrain';
    normTest=normTest';
    Train_Label=Label';
    Test_Label=TestLabel';
    Model = svmtrain(Train_Label,normTrain, '-t 2 -c 0.1');
    [train_label, accuracy, dec_values] = svmpredict(Train_Label, normTrain, Model);
    [predict_label, testaccuracy, dec_values] = svmpredict(Test_Label, normTest, Model);
    cv= svmtrain(Train_Label,normTrain,['-t 2 -c 0.1 -v 10']);
    CVerror=(100-cv)/100;
    TrainError=(100-accuracy(1))/100;
    TestError=(100-testaccuracy(1))/100;
    temptable.CV_Error=CVerror;
    temptable.Train_Error=TrainError;
    temptable.Test_Error=TestError;
    Table=[Table;temptable];