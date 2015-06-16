// System Includes
#include <iostream>
#include <math.h>
#include <sstream>
#include <fstream>
#include <string>
#include <time.h> 
using namespace std;

#include <ros/ros.h>
#include <ros/console.h>
#include <geometry_msgs/Twist.h>

//#include "/home/erobots/ros/rosbuild_ws/jaguar/layer2_msgs/msg_gen/cpp/include/layer2_msgs/cmd_speeds.h"
//#include "/home/erobots/ros/rosbuild_ws/jaguar/layer3_msgs/msg_gen/cpp/include/layer3_msgs/obs_pose_cov.h"
#include "/home/jr/catkin_ws/src/p2p_indigo/include/librerias/obs_pose_cov.h"
//#include "/home/erobots/ros/ros_workspace/src/align_indigo/msg_gen/cpp/include/align/align_params.h"

//#include "/home/erobots/ros/ros_workspace/src/p2p_indigo/msg_gen/cpp/include/p2p/p2p_params.h"
//#include "p2p/p2p_params.h"
//#include "align/align_params.h"
#include "obs_pose_cov.h"
#include "p2p/p2p_params.h"
#include "align/align_params.h"

#include "std_msgs/Int8.h"


//#include "../../settings.h"

#define rad2deg(radians) ((radians) * (180.0 / M_PI))
#define deg2rad(deg) ((deg) * (M_PI / 180.0))
#define fix_angle(angle)(atan2(sin(angle), cos(angle)))

string jaguar_id = "_001";

double robot_speed = 0.4;

ros::Subscriber child_pose_sub_;
ros::Subscriber p2p_params_sub_;
ros::Subscriber align_params_sub_;

ros::Publisher p2p_params_pub_;
//ros::Publisher cmd_speeds_pub_;
ros::Publisher align_params_pub_;
ros::Publisher move_pub_;

geometry_msgs::Twist cmdvel_;
layer3_msgs::obs_pose_cov posecov;
p2p::p2p_params p2p_parameters;
//layer2_msgs::cmd_speeds speeds_msg;
align::align_params align_msg;

double tx,ty,sx,sy;
double tolerance = .15;
double tolAngle = .1745;

double maxVel = 1.0;
double maxTurn = 1.0;

double calculateAngle(double sx, double sy)
{
	double angle = -555;

	if (sx == tx){
		if (sy - ty < 0) {
			angle = M_PI;
		} 
		else angle = 0;
	} 
	else if ( sy == ty) {
		if ( sx - tx < 0) {
			angle = M_PI/2;
		}
		else angle = -M_PI/2;
	}
	else {
		angle = (atan2((tx-sx),(-ty+sy)));
		//Se mandan los parametros primero x y luego y ya que se hicieron los calculos en excel y el atan2 se maneja de ese modo
	}

	return angle;
}

void callback_p2p_params(const p2p::p2p_params::ConstPtr& msg)
{
	p2p_parameters = *msg;
	tx = p2p_parameters.targetx;
	ty = p2p_parameters.targety;
	if (p2p_parameters.status == 0){
			ROS_ERROR("Entre a p2p 5");
			maxTurn = 0;
			maxVel = 0;
			cmdvel_.linear.x = maxVel;
        	cmdvel_.angular.z = maxTurn;
			cmdvel_.linear.y = 0;
			cmdvel_.linear.z = 0;
			move_pub_.publish(cmdvel_);
		}
	//p2p_parameters.targetx = fix_angle(deg2rad(p2p_parameters.targetx));
	//p2p_parameters.targety = fix_angle(deg2rad(p2p_parameters.targety));
}

void callback_align_params(const align::align_params::ConstPtr& msg)
{
	align_msg = *msg;
}

//void callback_nurse_cam(const geometry_msgs::Pose2D::ConstPtr& msg)
void callback_mcam(const layer3_msgs::obs_pose_cov::ConstPtr& msg)
{
	posecov = *msg;
	ROS_ERROR("STATUS = %d", p2p_parameters.status);
	

	if(posecov.robot_id==0)
	{
		sx=posecov.pose.x;
		sy=posecov.pose.y;


		ROS_ERROR("Sx = %f", sx);
	//sx=0;
	//sy=0;

		if (p2p_parameters.status == 1)
		{
			if ( sqrt((tx - sx)*(tx - sx) + (ty - sy)*(ty - sy)) < tolerance)
			{
				ROS_ERROR("Entre a p2p 1");
				if ((maxTurn != 0)&&(maxVel != 0)){
				//if ((speeds_msg.right != 0)||(speeds_msg.left != 0)){
					maxTurn = 0;
					maxVel = 0;
					cmdvel_.linear.x = maxVel;
        			cmdvel_.angular.z = maxTurn;
					cmdvel_.linear.y = 0;
					cmdvel_.linear.z = 0;
					move_pub_.publish(cmdvel_);

					//speeds_msg.left = 0;
					//speeds_msg.right = 0;
					//cmd_speeds_pub_.publish(speeds_msg);
				}

				p2p_parameters.status = 2;
				p2p_params_pub_.publish(p2p_parameters);

			}

			if ( abs(fix_angle(calculateAngle(sx, sy) - posecov.pose.theta)) < tolAngle){
				ROS_ERROR("Entre a p2p 2");
				maxTurn = robot_speed;
				maxVel = -robot_speed;
				cmdvel_.linear.x = maxVel;
        		cmdvel_.angular.z = maxTurn;
				cmdvel_.linear.y = 0;
				cmdvel_.linear.z = 0;
				move_pub_.publish(cmdvel_);

				//speeds_msg.left = 20;
				//speeds_msg.right = 20;
				//cmd_speeds_pub_.publish(speeds_msg);
			} else {
				ROS_ERROR("Entre a p2p 3");
				align_msg.angle = calculateAngle(sx, sy);
				align_msg.tolerance = tolAngle;
				align_msg.status = 4;
				align_msg.go = 0;
				align_params_pub_.publish(align_msg);

				p2p_parameters.status = 3;
				p2p_params_pub_.publish(p2p_parameters);
			}
		}
		else if (p2p_parameters.status == 3 && align_msg.go == 1){
			ROS_ERROR("Entre a p2p 4");
			p2p_parameters.status = 1;
			p2p_params_pub_.publish(p2p_parameters);
		}
		else if (p2p_parameters.status == 0){
			ROS_ERROR("Entre a p2p 5");
			maxTurn = 0;
			maxVel = 0;
			cmdvel_.linear.x = maxVel;
        	cmdvel_.angular.z = maxTurn;
			cmdvel_.linear.y = 0;
			cmdvel_.linear.z = 0;
			move_pub_.publish(cmdvel_);
		}
			
	}
}

int main(int argc, char **argv){
	ros::init(argc, argv, "p2p_001");
	ros::NodeHandle n;

	p2p_parameters.status = 0;

	child_pose_sub_ = n.subscribe<layer3_msgs::obs_pose_cov>("child_pose",10, callback_mcam);
	

	p2p_params_sub_ = n.subscribe<p2p::p2p_params>(("p2p_params"+jaguar_id), 1, callback_p2p_params);
	align_params_sub_ = n.subscribe<align::align_params>(("align_params"+jaguar_id), 1, callback_align_params);
	//cmd_speeds_pub_ = n.advertise<layer2_msgs::cmd_speeds>(("cmd_speeds"+jaguar_id),1);
	p2p_params_pub_ = n.advertise<p2p::p2p_params>(("p2p_params"+jaguar_id), 1);
	align_params_pub_ = n.advertise<align::align_params>(("align_params"+jaguar_id),1);
	move_pub_ = n.advertise<geometry_msgs::Twist>("drrobot_cmd_vel"+jaguar_id, 1);

 	ros::spin();
}