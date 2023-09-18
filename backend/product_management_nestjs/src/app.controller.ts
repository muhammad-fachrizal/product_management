import { Body, Controller, Delete, Get, Param, Patch, Post } from '@nestjs/common';
import { AppService } from './app.service';

@Controller()
export class AppController {
  constructor(private readonly appService: AppService) {}

  @Get()
  async getAllProduct(){
    const products = await this.appService.getAllProducts();
    return products;
  }

  @Get('findById/:id')
  getProduct(@Param('id') prodId: string) {
    return this.appService.getProduct(prodId);
  }

  @Post('add')
  async addProduct(@Body('title') prodTitle: string, @Body('description') prodDescripton: string, @Body('price') prodPrice: number, @Body('stock') prodStock: number){
    const generatedId = await this.appService.addProduct(prodTitle, prodDescripton, prodPrice, prodStock, new Date());
    console.log(`inside controller, new Date() value: ${new Date()}`);
    return {id: generatedId};
  }

  @Patch('update/:id')
  async updateProduct(@Param('id') prodId: string, @Body('title') prodTitle: string, @Body('description') prodDescripton: string, @Body('price') prodPrice: number, @Body('stock') prodStock: number){
    await this.appService.updateProduct(prodId, prodTitle, prodDescripton, prodPrice, prodStock, new Date());
    return {message: "Product updated successfully"};
  }

  @Delete('delete/:id')
  async deleteProduct(@Param('id') prodId: string){
    await this.appService.deleteProduct(prodId);
    return {message: "Product deleted successfully"};
  }
}
