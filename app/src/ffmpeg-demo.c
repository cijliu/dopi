#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include <unistd.h>
#include "avformat.h"
#include "avcodec.h"
#include "avdevice.h"
#include "opt.h"
#include "dict.h"
#include <signal.h>
#include <sys/types.h>
#include <sys/wait.h>

char* input_name= "hi3516ev200";//"video4linux2";
char* file_name = "imx307";//"/dev/video0";
char out_file[128];
int flag=1;

void captureOneFrame(void){
    AVFormatContext *fmtCtx = NULL;    
    AVPacket *packet;
    AVInputFormat *inputFmt;
    FILE *fp;
    int ret;
    AVDictionary *av_attr = NULL;
#if 1
    av_dict_set(&av_attr,"video_size","1080p",0);
    av_dict_set(&av_attr,"pixel_format","h264",0);
#endif


    inputFmt = av_find_input_format(input_name);    
    if (inputFmt == NULL)    {        
        printf("can not find_input_format\n");        
        return;    
    }    
   
    if (avformat_open_input ( &fmtCtx, file_name, inputFmt, &av_attr) < 0){
        printf("can not open_input_file\n");         return;    
    }
    /* print device information*/
    av_dump_format(fmtCtx, 0, file_name, 0);
    char *str = av_malloc(128);
    av_opt_get(fmtCtx->priv_data, "video_size",0, (uint8_t **)&str);
    printf("str:%s\n",str);
    av_free(str);
    
    
    sprintf(out_file, "test.yuv");
    fp = fopen(out_file, "wb");  
    printf("enter any key to snap, but 'q' is exit\n");
    int id=0;
    #if 1
    if((id=fork()) > 0){
        printf("id %d\n",id);
        packet = (AVPacket *)av_malloc(sizeof(AVPacket)); 
        printf("pid %d\n",waitpid(-1, NULL, WNOHANG));
        while(waitpid(id, NULL, WNOHANG) == 0){
            #if 1
            if(av_read_frame(fmtCtx, packet) < 0){
                printf("av_read_frame fail\n");  
                break;
            }
            //printf("data length = %d\n",packet->size);   
            
            
            if (fp < 0)    {        
                printf("open frame data file failed\n");        
                return ;    
            }    
            
            fwrite(packet->data, 1, packet->size, fp);    
            break;
            
            //printf("%s saved\n",out_file);   
            //printf("enter any key to snap, but 'q' is exit\n");
            #else
            int ret = 0;
            if((ret=av_read_frame(fmtCtx, packet)) < 0){
                printf("av_read_frame fail\n");  
                break;
            }
            printf("av_read_frame ret %d\n",ret);
            #endif
            usleep(100000);
        }
        av_packet_unref(packet);
        fflush(fp);
        fclose(fp);  
        avformat_close_input(&fmtCtx);
        printf("exit\n"); 
    }
    else if(id == 0){
        // printf("id %d\n",id);
        // while(getchar()!='q'){
        //    usleep(10000);
        //    break;
        // }
        // printf("exit child\n");    
        // sleep(1);
        // exit(0);
        
    }
    #else
    
    #endif
      
    
 }
 
int main(void){    
    avcodec_register_all();    
    avdevice_register_all();    
    captureOneFrame();    
    return 0;
}