Music Analysis
==============

This is a temporary holding directory for music analysis scripts.

there should be some sort of accessible backend that grabs an audio stream from
somewhere and converts it into a numpy array to be processed

then, there should be a series of processors that a plugin can take advantage
of.  maybe there should be some coarse-grained ones (dsp.howmuchbass()) and
some fine-grained ones (controllable-point fft)

FFT should be something to the effect of

1.  fill sample buffer
2.  apply windowing algorithm to sample set -- try hanning
3.  X = np.fft.rfft(windowed_data);
4.  Xdb = 20*np.log10(np.abs(X));
    
50% overlap between two sample buffers will likely work well

Testing with wave files:

    from scipy.io import wavfile
    fs, data = wavfile.read('/path/to/file.wav');
