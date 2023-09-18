import { Injectable, NotFoundException } from '@nestjs/common';
import { InjectModel } from '@nestjs/mongoose';
import { Model } from 'mongoose';
import { Product } from './product.model';

@Injectable()
export class AppService {
  constructor(@InjectModel('Product') private readonly productModel: Model<Product>){}
    async getAllProducts() {
        const products = await this.productModel.find().sort({lastModified: "desc"}).exec();
        return products.map(prod => ({id: prod.id, title: prod.title, description: prod.description, price: prod.price, stock: prod.stock}));
    }

    private async findProduct(productId: string) : Promise<Product> {
        let product;
        try {
            product = await this.productModel.findById(productId).exec();
        } catch (error) {
            throw new NotFoundException('Product not found');
        }
        if (!product) {
            throw new NotFoundException('Product not found');
        }
        console.log(product);
        return product;
    }

    async getProduct(productId: string) {
        const product = await this.findProduct(productId);
        return {id: product.id, title: product.title, description: product.description, price: product.price, stock: product.stock};
    }

    async addProduct(title: string, description: string, price: number, stock: number, lastModified: Date){
        const newProduct = new this.productModel({title: title, description: description, price: price, stock: stock, lastModified: lastModified});
        console.log(`inside controller, new Date() value: ${lastModified.toLocaleString()}`);
        const result = await newProduct.save();
        return result.id as string;
    }

    async updateProduct(productId: string, title: string, description: string, price: number, stock: number, lastModified: Date){
        const updatedProduct = await this.findProduct(productId);
        updatedProduct.lastModified = lastModified;
        if (title) {
            updatedProduct.title = title;
        }
        if(description) {
            updatedProduct.description = description;
        }
        if(price) {
            updatedProduct.price = price;
        }
        if(stock) {
            updatedProduct.stock = stock;
        }
        updatedProduct.save();
    }

    async deleteProduct(productId: string){
        const result = await this.productModel.deleteOne({_id: productId}).exec();
        if (result.deletedCount === 0) {
            throw new NotFoundException('Could not find product.');
        }
    }
}
