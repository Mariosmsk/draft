function [ compilerName ] = compiler_Name()
    compilerName = mex.getCompilerConfigurations('C','Selected').Name();    
end

