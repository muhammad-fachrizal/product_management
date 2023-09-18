import { Module } from '@nestjs/common';
import { AppController } from './app.controller';
import { AppService } from './app.service';
import { MongooseModule } from '@nestjs/mongoose';
import { ProductSchema } from './product.model';
//process.env.PORT
@Module({
  imports: [MongooseModule.forFeature([{name: 'Product', schema: ProductSchema}]), MongooseModule.forRoot('process.env.MONGO_URL')],
  controllers: [AppController],
  providers: [AppService],
})
export class AppModule {}
