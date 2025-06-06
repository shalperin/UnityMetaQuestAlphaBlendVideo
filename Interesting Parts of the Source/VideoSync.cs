using UnityEngine;
using UnityEngine.Video;

public class VideoSync : MonoBehaviour
{
    public VideoPlayer rgbPlayer;
    public VideoPlayer alphaPlayer;

    void Start()
    {
        rgbPlayer.isLooping = true;
        alphaPlayer.isLooping = true;
        
        rgbPlayer.Prepare();
        alphaPlayer.Prepare();

        rgbPlayer.prepareCompleted += OnPrepared;
        alphaPlayer.prepareCompleted += OnPrepared;
    }

    int preparedCount = 0;

    void OnPrepared(VideoPlayer vp)
    {
        preparedCount++;
        if (preparedCount >= 2)
        {
            rgbPlayer.Play();
            alphaPlayer.Play();
        }
    }
}
