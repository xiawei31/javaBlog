package itat.zttc.produce;

import java.util.Random;

public class Cooker implements Runnable{
	private String name;//生产者名字
	private String[] foods;//生产的商品
	private Disk d;//仓库
	private static Random ran = new Random(47);
	
	/*public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String[] getFoods() {
		return foods;
	}
	public void setFoods(String[] foods) {
		this.foods = foods;
	}
	public Disk getD() {
		return d;
	}
	public void setD(Disk d) {
		this.d = d;
	}*/
	//构造函数
	public Cooker(String name, Disk d) {
		this.name = name;
		this.d = d;
		foods = new String[]{"大米","馒头","包子","稀饭","果汁",
					"馊饭","砒霜","批萨","汉堡","红酒","火药","毒药","盐巴"};
	}
	//生产商品
	
	public void make() {
		//进行同步
		synchronized (d) {
			//如果d为空进行生产
			if(d.isEmpty()) {
				//随机生产商品
				int index = ran.nextInt(foods.length);
				String f = foods[index];
				System.out.println(name+"制作了"+f);
				//创库放置商品
				d.setFood(f);
				//设置创库不为空
				d.setEmpty(false);
				//唤起一次任务调度，此去唤醒消费者
				d.notify();
				try {
					//进行睡眠,需要这边的任务执行完成才执行消费者任务
					System.out.println("2000");
					Thread.sleep(2000);
					d.wait();
				} catch (InterruptedException e) {
					e.printStackTrace();
				}
			} else {
				//否则进行等待；
				try {
					d.wait();//需要另外的线程进行唤醒
				} catch (InterruptedException e) {
					e.printStackTrace();
				}
			}
		}
		
	}
	
	@Override
	public void run() {
		//进行20次生产；
		for(int i=0;i<20;i++) {
			make();
		}
	}
}
